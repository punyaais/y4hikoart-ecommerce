<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'
import { Search, CalendarDays, ShoppingCart } from 'lucide-vue-next'
import { useRouter } from 'vue-router'
import BackButton from '@/components/ui/BackButton.vue'

const orders = ref<any[]>([])
const loading = ref(false)
const router = useRouter()

const activeFilter = ref('all')
const search = ref('')

const fetchOrders = async () => {
  try {
    loading.value = true

    const token = localStorage.getItem('token')

    const res = await axios.get(
      'http://127.0.0.1:8000/api/me/orders',
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

    orders.value = res.data

  } catch (err) {
    console.error(err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchOrders()
})

const filteredOrders = computed(() => {
  return orders.value.filter(order => {

    // FILTER STATUS
    const matchFilter =
      activeFilter.value === 'all'
        ? true
        : order.status === activeFilter.value

    // SEARCH
    const keyword = search.value.toLowerCase()

    const customerName =
      order.customer_name?.toLowerCase() || ''

    const productName =
      order.product?.name?.toLowerCase() || ''

    const status =
      order.status?.toLowerCase() || ''

    const paymentStatus =
      order.payment?.payment_status?.toLowerCase() || ''

    const matchSearch =
      customerName.includes(keyword) ||
      productName.includes(keyword) ||
      status.includes(keyword) ||
      paymentStatus.includes(keyword)

    return matchFilter && matchSearch
  })
})

const setFilter = (filter: string) => {
  activeFilter.value = filter
}
const goToProgress = (orderId: number) => {
  router.push({
    path: '/orders-progress',
    query: { order_id: orderId }
  })
}
</script>

<template>
  <div class="min-h-screen orders-shell flex justify-center">

    <section class="w-full mx-auto max-w-7xl px-6 pt-36 pb-20 flex flex-col gap-5">

      <!-- HEADER -->
      <div class="flex flex-col gap-8 lg:flex-row lg:items-center lg:justify-between">
        <div>
          <p class="mb-2 text-sm font-bold uppercase tracking-[0.3em] text-[var(--color-primary)]">
            Commission Progress
          </p>

          <h1 class="text-4xl md:text-5xl font-black tracking-tight text-[var(--color-dark)]">
            Order List
          </h1>
        </div>

        <!-- SEARCH -->
        <div class="relative w-full max-w-[620px]">
          <div
            class="
              flex
              items-center
              rounded-full
              border
              border-white/40
              bg-[rgba(245,239,232,0.38)]
              px-5
              py-3
              backdrop-blur-xl
              shadow-[0_12px_30px_rgba(40,0,0,0.10)]
              transition-all
              duration-300
              focus-within:border-[var(--color-primary)]
              focus-within:shadow-[0_14px_34px_rgba(246,55,143,0.18)]
            "
          >
            <input
              v-model="search"
              type="text"
              placeholder="Search orders..."
              class="
                w-full
                bg-transparent
                text-lg
                md:text-xl
                text-[var(--color-dark)]
                outline-none
                placeholder:text-[var(--color-dark)]/40
              "
            />

            <Search class="h-6 w-6 text-[var(--color-dark)]/75" />
          </div>
        </div>
      </div>

      <!-- FILTER -->
      <div
        class="
          mt-14
          flex
          flex-wrap
          gap-5
          justify-center
        "
      >
        <button
          v-for="item in ['all', 'wip', 'done', 'canceled']"
          :key="item"
          @click="setFilter(item)"
          class="
            min-w-[220px]
            rounded-full
            border-2
            border-[var(--color-soft)]
            px-8
            py-2
            text-2xl
            font-bold
            uppercase
            transition-all
          "
          :class="
            activeFilter === item
              ? 'bg-[var(--color-soft)] text-[var(--color-dark)] shadow-lg'
              : 'bg-white/25 backdrop-blur-md text-[var(--color-dark)]'
          "
        >
          {{ item }}
        </button>
      </div>

      <!-- CARDS -->
<template v-if="filteredOrders.length > 0">

  <div
        class="
          mt-16
          min-h-[900px]
          grid
          gap-5
          sm:grid-cols-2
          lg:grid-cols-3
          xl:grid-cols-4
          content-start
        "
      >
        <div
          v-for="order in filteredOrders"
          :key="order.order_id"
          class="flex flex-col gap-2"
        >

          <div
            class="
              overflow-hidden
              rounded-xl
              bg-[var(--color-light)]
              backdrop-blur-xl
              border
              border-white/40
              shadow-[0_14px_30px_rgba(40,0,0,0.08)]
            "
          >
            <!-- TOP -->
            <div
              class="
                flex
                items-center
                gap-3
                bg-[var(--color-primary)]
                px-5
                py-4
                text-[var(--color-light)]
              "
            >
              <CalendarDays class="h-6 w-6" />

              <p class="text-2xl font-bold">
                {{
                  new Date(order.created_at).toLocaleDateString(
                    'en-US',
                    {
                      month: 'short',
                      day: 'numeric',
                      year: 'numeric'
                    }
                  )
                }}
              </p>
            </div>

            <!-- BODY -->
            <div class="space-y-5 p-5">

              <!-- STATUS -->
            <div class="flex flex-wrap gap-3">

            <!-- PAYMENT STATUS -->
            <span
                class="
                rounded-full
                px-4
                py-2
                text-xl
                font-bold
                "
                :class="
                order.payment?.payment_status === 'paid'
                    ? 'bg-[var(--color-soft)] text-white'
                    : 'bg-[var(--color-cream)] text-[var(--color-primary)]'
                "
            >
                {{
                order.payment?.payment_status === 'paid'
                    ? 'Paid'
                    : 'Unpaid'
                }}
            </span>

            </div>

              <div>
                <p class="text-3xl text-[var(--color-dark)]/70">
                  {{ order.customer_name }}
                </p>

                <h2
                  class="
                    mt-2
                    text-4xl
                    font-black
                    text-[var(--color-dark)]
                    uppercase
                  "
                >
                  {{ order.product?.name }}
                </h2>
              </div>
            </div>
          </div>

          <!-- BUTTON -->
          <button
            v-if="order.status !== 'canceled'"
            @click="goToProgress(order.order_id)"
            class="
              mt-4
              w-full
              rounded-xl
              bg-[var(--color-secondary)]
              py-3
              text-xl
              md:text-2xl
              font-black
              text-[var(--color-dark)]
              shadow-lg
              transition-all
              duration-300
              hover:scale-[1.03]
              hover:shadow-xl
            "
          >
            View Progress
          </button>

          <div
            v-else
            class="
              mt-4
              flex
              w-full
              items-center
              justify-center
              rounded-xl
              bg-red-100
              py-3
              text-xl
              md:text-2xl
              font-black
              text-red-500
              border-2
              border-red-300
            "
          >
            Order Canceled
          </div>
        </div>
      </div>

</template>

<!-- EMPTY -->
<template v-else>

  <div
    class="
      mt-20
      min-h-[700px]
      flex
      flex-col
      items-center
      justify-center
      gap-6
      text-center
    "
  >
    <div
            class="w-24 h-24 rounded-full bg-[var(--color-primary)]/10 flex items-center justify-center animate-bounce"
          >
            <ShoppingCart class="w-10 h-10 text-[var(--color-primary)]" />
          </div>

    <h2
      class="
        text-4xl
        font-black
        text-[var(--color-dark)]
      "
    >
      No Orders Yet
    </h2>

    <p
      class="
        max-w-xl
        text-xl
        leading-9
        text-[var(--color-dark)]/70
      "
    >
      Looks like you haven’t placed any commission orders yet.
      Start exploring and create your first artwork order ⸜(｡˃ ᵕ ˂ )⸝♡
    </p>

    <button
      @click="router.push('/shop')"
      class="
        mt-2
        rounded-2xl
        bg-[var(--color-secondary)]
        px-8
        py-3
        text-2xl
        font-bold
        text-[var(--color-dark)]
        shadow-lg
        transition-all
        duration-300
        hover:scale-105
        hover:shadow-xl
      "
    >
      Continue Shopping
    </button>
  </div>

</template>
    </section>
    
  </div>
  <BackButton />
</template>