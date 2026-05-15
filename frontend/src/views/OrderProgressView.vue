<script setup lang="ts">
import axios from 'axios'
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import BackButton from '@/components/ui/BackButton.vue'
import { ShoppingCart } from 'lucide-vue-next'
import {
  ArrowLeft,
  CheckCircle2,
  Circle,
  Star,
  MessageSquareText,
  ShieldCheck,
  ChevronDown
} from 'lucide-vue-next'

const route = useRoute()
const router = useRouter()

const loading = ref(false)
const order = ref<any>(null)
const submittingReview = ref(false)

const stages = [
  { value: 'Sketch Phase', label: 'Sketch Phase' },
  { value: 'Sketch Approve', label: 'Sketch Approval' },
  { value: 'Payment Pending', label: 'Payment Pending' },
  { value: 'Payment Receive', label: 'Payment Received' },
  { value: 'Lineart Phase', label: 'Lineart Phase' },
  { value: 'Coloring/Detailing', label: 'Coloring / Detailing' },
  { value: 'Background and Finishing', label: 'Background & Finishing' },
  { value: 'Complete', label: 'Complete' }
]

const reviewRating = ref(5)
const reviewComment = ref('')
const showUsername = ref(true)

const imageUrl = (url?: string) => {
  if (!url) return ''

  if (url.startsWith('http')) return url

  // Support legacy value like "/storage/app/public/characters/xxx.png"
  if (url.startsWith('/storage/app/public')) {
    return `http://127.0.0.1:8000${url.replace('/storage/app/public', '/storage')}`
  }

  return `http://127.0.0.1:8000${url}`
}

const formatPrice = (price: number) => {
  return `IDR ${(Number(price || 0) / 1000).toFixed(0)}K`
}

const formatDate = (date?: string | null) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('en-US', {
    month: 'long',
    day: 'numeric',
    year: 'numeric'
  })
}

const fetchOrder = async () => {
  try {
    loading.value = true

    const token = localStorage.getItem('token')
    const res = await axios.get(
      `http://127.0.0.1:8000/api/orders/${route.query.order_id}`,
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

    order.value = res.data

    // accordion state
    order.value.characters = (order.value.characters || []).map((char: any, index: number) => ({
      ...char,
      open: index === 0
    }))
  } catch (err) {
    console.error(err)
  } finally {
    loading.value = false
  }
}

onMounted(fetchOrder)

const toggleCharacter = (index: number) => {
  const char = order.value?.characters?.[index]
  if (!char) return
  char.open = !char.open
}

const currentStageIndex = computed(() => {
  const stage = order.value?.progress_stage
  const index = stages.findIndex(s => s.value === stage)
  return index === -1 ? 0 : index
})

const completedStages = computed(() => currentStageIndex.value)

const isCompleted = computed(() => {
  return order.value?.progress_stage === 'Complete' || order.value?.status === 'done'
})
const finishDate = computed(() => {
  if (!isCompleted.value) {
    return 'In Progress'
  }

  return formatDate(
    order.value?.updated_at ||
    order.value?.completed_at
  )
})

const canReview = computed(() => {
  return isCompleted.value && !order.value?.testimonial
})

const backgroundTotal = computed(() => {
  return (order.value?.characters || []).reduce(
    (sum: number, char: any) => sum + Number(char.background?.price || 0),
    0
  )
})

const subtotal = computed(() => {

  const qty = Number(order.value?.quantity || 1)

  return (
    Number(order.value?.product?.price || 0) * qty
  ) + backgroundTotal.value

})

const total = computed(() => {
  return subtotal.value + Number(order.value?.admin_fee || 0) - Number(order.value?.discount_amount || 0)
})

const goBack = () => {
  router.back()
}

const payNow = async () => {
  try {
    const token = localStorage.getItem('token')

    // kalau payment url sudah ada → langsung buka
    if (order.value?.payment?.payment_url) {
      window.location.href = order.value.payment.payment_url
      return
    }

    // buat invoice baru ke xendit
    const res = await axios.post(
      'http://127.0.0.1:8000/api/payment/xendit',
      {
        order_ids: [order.value.order_id],
        email: order.value.customer_email
      },
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

    // redirect ke xendit
    if (res.data.invoice_url) {
      window.location.href = res.data.invoice_url
    }

  } catch (err) {
    console.error(err)
  }
}

const submitReview = async () => {
  try {
    if (!order.value || !canReview.value) return

    submittingReview.value = true

    const token = localStorage.getItem('token')

    const res = await axios.post(
      'http://127.0.0.1:8000/api/testimonials',
      {
        order_id: order.value.order_id,
        rating: reviewRating.value,
        comment: reviewComment.value,
        show_username: showUsername.value
      },
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

    order.value.testimonial = res.data.data
    reviewComment.value = ''
    reviewRating.value = 5
    showUsername.value = true
  } catch (err) {
    console.error(err)
  } finally {
    submittingReview.value = false
  }
}
const canCancelOrder = computed(() => {
  return (
    order.value?.progress_stage === 'Sketch Phase' &&
    order.value?.status !== 'canceled'
  )
})
const cancelOrder = async () => {
  try {
    const token = localStorage.getItem('token')

    await axios.put(
      `http://127.0.0.1:8000/api/orders/${order.value.order_id}/cancel`,
      {},
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

    order.value.status = 'canceled'

    // redirect keluar halaman progress
    router.push('/orders')

  } catch (err) {
    console.error(err)
  }
}
const chatLink = 'https://ig.me/m/y4hikoart'

const openChat = () => {
  window.open(chatLink, '_blank')
}
</script>

<template>
  <div class="min-h-screen order-progress-shell px-4 py-10 pt-30 text-[var(--color-dark)] md:px-8 flex justify-center">
    <div v-if="loading" class="flex min-h-[50vh] items-center justify-center text-3xl ">
      Loading...
    </div>

    <div v-else-if="order" class="max-w-6xl w-full flex flex-col gap-5">
      <!-- HEADER -->
      <div class="rounded-2xl bg-[var(--color-light)] px-6 py-5 shadow-sm">
        <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
          <div>
            <p class="text-2xl  uppercase tracking-[0.25em] text-[var(--color-primary)]">
              Order Progress
            </p>
            <h1 class="mt-2 text-3xl  md:text-4xl">
              Order - Progress
            </h1>
          </div>

          <div class="flex flex-wrap items-center gap-3">
            <div
              class="rounded-full px-4 py-2 text-2xl  uppercase tracking-[0.18em]"
              :class="order.status === 'done'
                ? 'bg-[var(--color-secondary)]'
                : 'bg-[var(--color-cream)]'"
            >
              {{ order.status || 'wip' }}
            </div>
          </div>
        </div>
      </div>

      <!-- TOP SECTION -->
      <div class="grid gap-6 lg:grid-cols-[1.05fr_0.95fr]">
        <!-- LEFT -->
        <div class="rounded-2xl  bg-[var(--color-light)] p-6 shadow-sm md:p-7">
          <div class="grid gap-5">
            <div class="rounded-2xl border border-[var(--color-soft)]/60 bg-[var(--color-cream)]/45 p-5">
              <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">Client</p>
              <p class="mt-2 text-2xl ">
                {{ order.customer_name }}
              </p>
              <p class="mt-1 text-2xl opacity-80">
                {{ order.customer_email }}
              </p>
            </div>

            <div class="rounded-2xl border border-[var(--color-soft)]/60 bg-[var(--color-light)] p-5">
              <div class="mb-5 flex items-center justify-between gap-4">
                <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">
                  Order Details
                </p>
                <p class="text-2xl  uppercase tracking-[0.18em] text-[var(--color-1)]">
                  {{ order.product?.name }}
                </p>
              </div>

              <div class="space-y-4">
                <div class="flex items-start justify-between gap-5">
                  <p class="text-2xl font-semibold">
                    {{ order.quantity || 1 }} × {{ order.product?.name }}
                  </p>
                  <p class="whitespace-nowrap text-2xl ">
                    {{ formatPrice((order.product?.price || 0) * (order.quantity || 1)) }}
                  </p>
                </div>

                <div
                  v-for="char in order.characters || []"
                  :key="char.character_id"
                  class="flex items-start justify-between gap-5"
                >
                  <p class="text-2xl font-semibold">
                    1 × {{ char.background?.name || 'No Background' }}
                  </p>
                  <p class="whitespace-nowrap text-2xl ">
                    {{ formatPrice(char.background?.price || 0) }}
                  </p>
                </div>
              </div>

              <div class="mt-6 rounded-2xl border border-[var(--color-soft)]/50 bg-[var(--color-cream)]/35 p-5">
                <div class="space-y-3">
                  <div class="flex items-center justify-between gap-5">
                    <p class="text-2xl">Subtotal</p>
                    <p class="whitespace-nowrap text-2xl ">
                      {{ formatPrice(subtotal) }}
                    </p>
                  </div>

                  <div class="flex items-center justify-between gap-5">
                    <p class="text-2xl">Discount</p>
                    <p class="whitespace-nowrap text-2xl ">
                      - {{ formatPrice(order.discount_amount || 0) }}
                    </p>
                  </div>

                  <div class="flex items-center justify-between gap-5">
                    <p class="text-2xl">Admin fee</p>
                    <p class="whitespace-nowrap text-2xl ">
                      {{ formatPrice(order.admin_fee || 0) }}
                    </p>
                  </div>

                  <div class="h-px bg-[var(--color-soft)]/40"></div>

                  <div class="flex items-center justify-between gap-5">
                    <p class="text-2xl ">Total</p>
                    <p class="whitespace-nowrap text-2xl ">
                      {{ formatPrice(total) }}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- RIGHT -->
        <div class="flex flex-col gap-5">
          <div class="rounded-2xl  bg-[var(--color-light)] p-6 shadow-sm md:p-7">
            <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">
              Artist
            </p>
            <p class="mt-2 text-2xl ">
              y4hikoart (Aii)
            </p>
          </div>

          <div class="rounded-2xl  bg-[var(--color-light)] p-6 shadow-sm md:p-7">
            <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">
              Payment
            </p>
            <p class="mt-2 text-2xl  uppercase">
              {{ order.payment?.payment_method || '-' }}
            </p>
            <div class="mt-4 inline-flex rounded-full bg-[var(--color-cream)] px-4 py-2 text-2xl ">
              {{ order.payment?.payment_status || 'pending' }}
            </div>
          </div>

          <div class="rounded-2xl  bg-[var(--color-light)] p-6 shadow-sm md:p-7">
            <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">
              Order Date
            </p>
            <p class="mt-2 text-2xl ">
              {{ formatDate(order.created_at || order.order_date) }}
            </p>
          </div>

          <div class="rounded-2xl  bg-[var(--color-light)] p-6 shadow-sm md:p-7">
            <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">
              Finish Date Estimated
            </p>
            <p class="mt-2 text-2xl ">
              {{ finishDate }}
            </p>
          </div>
        </div>
      </div>

      
      <!-- PROGRESS -->
      <div class="rounded-2xl  bg-[var(--color-light)] p-6 shadow-sm md:p-7">
        <h2 class="mb-8 text-2xl  md:text-3xl">
          Progress Stages
        </h2>

        <div class="grid gap-8 lg:grid-cols-[1fr_0.95fr]">
          <div class="relative pl-2">
            <div class="absolute left-[18px] top-0 h-full w-px bg-[var(--color-soft)]"></div>

            <div
              v-for="(stage, index) in stages"
              :key="stage.value"
              class="relative mb-3 flex items-center gap-4 rounded-2xl border-2 px-4 py-4 transition"
              :class="[
                index < completedStages
                  ? 'border-[var(--color-soft)]/70 bg-[var(--color-cream)]/40'
                  : index === currentStageIndex
                    ? 'border-[var(--color-primary)] bg-[var(--color-cream)]'
                    : 'border-[var(--color-soft)]/50 bg-[var(--color-light)]'
              ]"
            >
              <div
                class="flex h-7 w-7 shrink-0 items-center justify-center rounded-full border-2"
                :class="[
                  index <= currentStageIndex
                    ? 'border-[var(--color-primary)] bg-[var(--color-primary)]'
                    : 'border-[var(--color-soft)] bg-[var(--color-light)]'
                ]"
              >
                <CheckCircle2
                  v-if="index <= currentStageIndex"
                  class="h-4 w-4 text-[var(--color-light)]"
                />
                <Circle
                  v-else
                  class="h-4 w-4 text-[var(--color-soft)]"
                />
              </div>

              <div class="min-w-0">
                <p class="text-2xl  uppercase tracking-[0.18em] text-[var(--color-primary)]">
                  Step {{ index + 1 }}
                </p>
                <p class="truncate text-2xl ">
                  {{ stage.label }}
                </p>
              </div>

              <div
                class="ml-auto rounded-full px-3 py-1 text-xl  uppercase tracking-[0.18em]"
                :class="[
                  index < currentStageIndex
                    ? 'bg-[var(--color-secondary)]'
                    : index === currentStageIndex
                      ? 'bg-[var(--color-primary)] text-[var(--color-light)]'
                      : 'bg-[var(--color-cream)]'
                ]"
              >
                {{
                  index < currentStageIndex
                    ? 'Done'
                    : index === currentStageIndex
                      ? 'Current'
                      : 'Next'
                }}
              </div>
            </div>
          </div>

          <div class="flex flex-col gap-5">
            <div class="rounded-2xl  bg-[var(--color-light)] p-5">
              <div class="flex items-start justify-between gap-4">
                <div>
                  <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">
                    Current Stage
                  </p>
                  <p class="mt-1 text-2xl ">
                    {{ order.progress_stage || 'Sketch Phase' }}
                  </p>
                </div>

                <div
                  class="rounded-full px-4 py-2 text-2xl  uppercase"
                  :class="isCompleted ? 'bg-[var(--color-secondary)]' : 'bg-[var(--color-cream)]'"
                >
                  {{ isCompleted ? 'Completed' : 'In Progress' }}
                </div>
              </div>
            </div>

            <div class="rounded-2xl  bg-[var(--color-light)] p-5">
              <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">
                Note
              </p>

              <p class="mt-3 leading-7 text-xl">
                Your order will move to the next stage after full payment has been received.
              </p>

              <p class="mt-2 leading-7 text-xl">
                If payment is not completed within 2 days, the order can be cancelled.
              </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">

            <!-- CHAT -->
            <button
              @click="openChat"
              class="
                rounded-xl
                text-2xl
                bg-[var(--color-secondary)]
                py-3
                text-[var(--color-dark)]
                shadow-sm
                transition
                hover:scale-[1.02]
              "
            >
              Chat Me
            </button>

            <!-- PAY -->
            <button
              v-if="
                order.payment?.payment_status !== 'paid' &&
                order.status !== 'canceled'
              "
              @click="payNow"
              class="
                rounded-xl
                text-2xl
                bg-[var(--color-secondary)]
                py-3
                text-[var(--color-dark)]
                shadow-sm
                transition
                hover:scale-[1.02]
              "
            >
              Pay Now
            </button>

            <div
              v-else
              class="
                flex
                items-center
                justify-center
                rounded-xl
                bg-[var(--color-soft)]
                py-3
                text-2xl
                text-[var(--color-dark)]
              "
            >
              Payment Completed
            </div>

            <!-- CANCEL -->
            <button
              v-if="canCancelOrder"
              @click="cancelOrder"
              class="
                rounded-xl
                border-2
                border-red-400
                bg-red-100
                py-3
                text-2xl
                text-red-600
                transition
                hover:bg-red-200
              "
            >
              Cancel Order
            </button>

          </div>

            <div class="rounded-2xl  bg-[var(--color-cream)]/35 p-5">
              <div class="flex items-center gap-3">
                <ShieldCheck class="h-5 w-5 text-[var(--color-primary)]" />
                <p class="text-2xl text-[var(--color-dark)]">
                  Review is unlocked after the order is completed.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- TESTIMONIAL -->
      <div class="rounded-2xl  bg-[var(--color-light)] p-6 shadow-sm md:p-7">
        <h2 class="mb-3 text-2xl  md:text-3xl">
          Leave a Review
        </h2>

        <div v-if="order.testimonial" class="space-y-4">
          <p class="text-2xl  uppercase tracking-[0.2em] text-[var(--color-primary)]">
            Review already submitted
          </p>

          <div class="white-box">
            <div class="flex items-center gap-1">
              <Star
                v-for="n in 5"
                :key="n"
                class="h-4 w-4"
                :class="
                  n <= order.testimonial.rating
                    ? 'fill-[var(--color-secondary)] text-[var(--color-secondary)]'
                    : 'text-[var(--color-soft)]'
                "
              />
            </div>

            <p class="mt-3 whitespace-pre-wrap leading-7">
              {{ order.testimonial.comment }}
            </p>

            <p class="mt-3 text-2xl  uppercase tracking-[0.18em] text-[var(--color-primary)]">
              {{
                order.testimonial.show_username
                  ? (order.testimonial.user?.name || order.testimonial.user?.username || 'Customer')
                  : 'Anonymous'
              }}
            </p>
          </div>
        </div>

        <div v-else-if="canReview" class="space-y-5">
          <div class="rounded-2xl  bg-[var(--color-cream)]/35 p-5">
            <div class="flex items-center gap-3">
              <MessageSquareText class="h-5 w-5 text-[var(--color-primary)]" />
              <p class="font-bold text-2xl">
                Your order is complete. You can leave a short review now.
              </p>
            </div>
          </div>

          <textarea
            v-model="reviewComment"
            placeholder="Write your review..."
            class="white-box h-40 w-full resize-none outline-none text-2xl"
          />

          <div class="flex flex-col gap-3">
            <label
              class="uppercase tracking-[0.18em] text-[var(--color-primary)] text-xl"
            >
              Rating
            </label>

            <div class="flex items-center gap-2">
              <button
                v-for="n in 5"
                :key="n"
                type="button"
                @click="reviewRating = n"
                class="transition hover:scale-110"
              >
                <Star
                  class="h-9 w-9"
                  :class="
                    n <= reviewRating
                      ? 'fill-[var(--color-secondary)] text-[var(--color-secondary)]'
                      : 'text-[var(--color-soft)]'
                  "
                />
              </button>

              <span class="ml-2 text-xl font-bold text-[var(--color-dark)]">
                {{ reviewRating }}/5
              </span>
            </div>
          </div>

          <label class="flex items-center gap-3 rounded-2xl  bg-[var(--color-light)] p-4">
            <input
              v-model="showUsername"
              type="checkbox"
              class="h-5 w-5 accent-[var(--color-primary)]"
            />
            <span class="font-medium text-xl">
              Allow my username to be shown with my rating
            </span>
          </label>

          <button
            @click="submitReview"
            :disabled="submittingReview"
            class="rounded-xl bg-[var(--color-secondary)] px-8 py-1 pb-2 text-2xl text-[var(--color-dark)] shadow-sm transition disabled:opacity-60"
          >
            {{ submittingReview ? 'Saving...' : 'Submit Rating' }}
          </button>
        </div>

        <div v-else class="rounded-2xl  bg-[var(--color-cream)]/35 p-5 leading-7 text-2xl">
          Review will be available after the order is completed.
        </div>
      </div>
    </div>
  </div>
  
  <BackButton />
</template>

