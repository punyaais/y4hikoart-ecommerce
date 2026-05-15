<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { Minus, Plus, X, Check, ShoppingCart } from 'lucide-vue-next'
import BackButton from '@/components/ui/BackButton.vue'
import SlotIndicator from '@/components/ui/SlotIndicator.vue'

const router = useRouter()

const cart = ref<any>(null)
const loading = ref(true)
const error = ref('')
const selectedCheckoutIds = ref<number[]>([])
const remainingSlot = ref(0)

const fetchSlot = async () => {
  try {
    const res = await axios.get('http://127.0.0.1:8000/api/slots')
    remainingSlot.value = res.data.remaining_slots ?? 0
  } catch (err) {
    console.error('ERROR SLOT:', err)
  }
}

const fetchCart = async () => {
  loading.value = true
  error.value = ''

  try {

    const token = localStorage.getItem('token')

    const res = await axios.get(
      'http://127.0.0.1:8000/api/cart',
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

    cart.value = res.data || { items: [] }

    if (cart.value?.items?.length) {

      selectedCheckoutIds.value =
        selectedCheckoutIds.value.filter((id: number) =>
          cart.value.items.some((item: any) => item.id === id)
        )

    } else {

      selectedCheckoutIds.value = []

    }

  } catch (err) {

    console.error('ERROR FETCH CART:', err)
    error.value = 'Failed to load cart'

  } finally {

    loading.value = false

  }
}

onMounted(() => {
  fetchCart()
  fetchSlot()
})

const isSelectedForCheckout = (id: number) => selectedCheckoutIds.value.includes(id)

const toggleCheckoutSelect = (id: number) => {
  if (isSelectedForCheckout(id)) {
    selectedCheckoutIds.value = selectedCheckoutIds.value.filter(itemId => itemId !== id)
  } else {
    selectedCheckoutIds.value.push(id)
  }
}

const selectAllCheckout = () => {
  selectedCheckoutIds.value = (cart.value?.items || []).map((item: any) => item.id)
}

const clearCheckoutSelection = () => {
  selectedCheckoutIds.value = []
}

const increase = async (item: any) => {
  try {

    if (item.quantity >= remainingSlot.value) return

    const newQty = item.quantity + 1
    item.quantity = newQty

    const token = localStorage.getItem('token')

    await axios.post(
      `http://127.0.0.1:8000/api/cart/update/${item.id}`,
      {
        quantity: newQty
      },
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

  } catch (err) {

    console.error('ERROR INCREASE:', err)
    item.quantity = item.quantity - 1

  }
}

const decrease = async (item: any) => {
  try {
    if (item.quantity <= 1) return

    const newQty = item.quantity - 1
    item.quantity = newQty

    const token = localStorage.getItem('token')

    await axios.post(
      `http://127.0.0.1:8000/api/cart/update/${item.id}`,
      {
        quantity: newQty
      },
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )
  } catch (err) {
    console.error('ERROR DECREASE:', err)
    item.quantity = item.quantity + 1
  }
}

const removeItem = async (id: number) => {
  try {

    cart.value.items =
      cart.value.items.filter((item: any) => item.id !== id)

    selectedCheckoutIds.value =
      selectedCheckoutIds.value.filter(itemId => itemId !== id)

    const token = localStorage.getItem('token')

    await axios.delete(
      `http://127.0.0.1:8000/api/cart/${id}`,
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

  } catch (err) {

    console.error('ERROR REMOVE:', err)
    await fetchCart()

  }
}

const total = computed(() => {
  if (!cart.value?.items?.length) return 0

  return cart.value.items.reduce((sum: number, item: any) => {
    return sum + Number(item.product.price || 0) * Number(item.quantity || 0)
  }, 0)
})

const selectedTotal = computed(() => {
  if (!cart.value?.items?.length) return 0

  return cart.value.items
    .filter((item: any) => selectedCheckoutIds.value.includes(item.id))
    .reduce((sum: number, item: any) => {
      return sum + Number(item.product.price || 0) * Number(item.quantity || 0)
    }, 0)
})

const formatPrice = (price: number) => {
  return `IDR ${(price / 1000).toFixed(0)}K`
}

const goToCheckout = () => {
  if (!selectedCheckoutIds.value.length) return

  if (selectedQuantity.value > remainingSlot.value) {
    alert('Selected quantity exceeds available slot')
    return
  }

  router.push({
    path: '/checkout',
    query: {
      mode: 'cart',
      selected: selectedCheckoutIds.value.join(',')
    }
  })
}

const selectedQuantity = computed(() => {
  if (!cart.value?.items?.length) return 0

  return cart.value.items
    .filter((item: any) => selectedCheckoutIds.value.includes(item.id))
    .reduce((sum: number, item: any) => {
      return sum + Number(item.quantity || 0)
    }, 0)
})
const imageUrl = (path?: string) => {
  if (!path) return ''

  if (path.startsWith('http')) {
    return path
  }

  return `http://127.0.0.1:8000${path}`
}
</script>

<template>
  <div class="cart-shell min-h-screen py-10 flex justify-center">
    <div class="max-w-6xl w-full px-4 pt-20 flex flex-col gap-5">
      <div class="bg-[var(--color-light)] p-6 rounded-xl shadow text-center text-3xl font-bold text-[var(--color-dark)]">
        Your Cart
      </div>

      <div class="bg-[var(--color-light)] rounded-2xl shadow-lg p-6 md:p-8">
        <div v-if="loading" class="py-20 text-center text-xl">
          Loading...
        </div>

        <div v-else-if="error" class="py-20 text-center text-xl text-red-500">
          {{ error }}
        </div>

        <div
          v-else-if="!cart?.items || cart.items.length === 0"
          class="py-20 flex flex-col items-center text-center gap-6"
        >
          <!-- ICON -->
          <div
            class="w-24 h-24 rounded-full bg-[var(--color-primary)]/10 flex items-center justify-center animate-bounce"
          >
            <ShoppingCart class="w-10 h-10 text-[var(--color-primary)]" />
          </div>

          <!-- TITLE -->
          <h2 class="text-3xl font-bold text-[var(--color-dark)]">
            Your cart is empty
          </h2>

          <!-- SUBTEXT -->
          <p class="text-lg text-[var(--color-dark)]/70 max-w-md">
            Looks like you haven’t added anything yet.  
            Start exploring and find something you love ⸜(｡˃ ᵕ ˂ )⸝♡
          </p>

          <!-- BUTTON -->
          <button
            @click="router.push('/shop')"
            class="mt-2 bg-[var(--color-secondary)] px-8 py-3 rounded-xl font-bold text-[var(--color-dark)] text-lg shadow-md hover:scale-105 hover:shadow-lg transition"
          >
            Continue Shopping
          </button>
        </div>

        <div v-else class="flex flex-col gap-5">
          <div
            v-for="item in cart.items"
            :key="item.id"
            class="relative rounded-2xl border border-[var(--color-soft)]/40 bg-[var(--color-light)] shadow-sm p-4 md:p-5 flex flex-col md:flex-row md:items-center gap-4 transition"
          >
            <!-- BUTTON HAPUS POJOK KANAN ATAS -->
            <button
              @click="removeItem(item.id)"
              class="absolute top-3 right-3 w-8 h-8 rounded-full bg-[var(--color-primary)] text-[var(--color-light)] flex items-center justify-center shadow hover:scale-[1.05] transition shrink-0"
            >
              <X class="w-4 h-4" />
            </button>

            <button
              @click="toggleCheckoutSelect(item.id)"
              class="w-6 h-6 rounded-md border flex items-center justify-center transition shrink-0"
              :class="isSelectedForCheckout(item.id)
                ? 'border-[var(--color-primary)] bg-[var(--color-primary)] text-[var(--color-light)]'
                : 'border-[var(--color-soft)]/60 bg-[var(--color-cream)] text-transparent'"
            >
              <Check class="w-4 h-4" />
            </button>

            <img
              :src="imageUrl(item.product.image_url)"
              :alt="item.product.name"
              class="w-[190px] max-w-sm aspect-square object-cover rounded-xl border border-[var(--color-soft)]/30 shrink-0"
            />

            <div class="flex-1 min-w-0 ">
              <div class="flex items-start justify-between gap-3 ">
                <div class="min-w-0">
                  <h2 class="text-2xl font-bold uppercase text-[var(--color-dark)] truncate">
                    {{ item.product.name }}
                  </h2>
                  <p class="text-lg mt-1 text-[var(--color-dark)]/80 font-mono">
                    {{ formatPrice(item.product.price) }}
                  </p>
                </div>
              </div>

              <div class="flex items-end justify-between flex-wrap">
                <div class="flex flex-col gap-2">
                  <div class="flex items-center border rounded-lg border-[var(--color-primary)] overflow-hidden bg-[var(--color-light)]">
                    <button
                      @click="decrease(item)"
                      :disabled="item.quantity <= 1"
                      class="w-10 h-10 flex items-center justify-center hover:bg-pink-100 transition disabled:opacity-40 disabled:cursor-not-allowed"
                    >
                      <Minus class="w-4 h-4 text-[var(--color-dark)]" />
                    </button>

                    <span class="w-12 pb-2 text-center text-2xl text-[var(--color-dark)] font-semibold">
                      {{ item.quantity }}
                    </span>

                    <button
                      @click="increase(item)"
                      :disabled="item.quantity >= remainingSlot"
                      class="w-10 h-10 flex items-center justify-center hover:bg-pink-100 transition disabled:opacity-40 disabled:cursor-not-allowed"
                    >
                      <Plus class="w-4 h-4 text-[var(--color-dark)]" />
                    </button>
                  </div>
                </div>

                <div class="flex flex-col items-end gap-2">
                  <span class="text-3xl text-[var(--color-dark)]/70">Subtotal</span>
                  <p class="text-xl text-[var(--color-dark)] font-bold font-mono">
                    {{ formatPrice(Number(item.product.price || 0) * Number(item.quantity || 0)) }}
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div class="mt-2 rounded-2xl border border-[var(--color-soft)]/40 bg-[var(--color-light)] shadow-sm p-5 md:p-6 flex flex-col gap-3">

            <div class="mt-2 flex justify-between items-center text-2xl font-bold text-[var(--color-dark)] uppercase">
              <span>Total</span>
              <span class="font-mono">{{ formatPrice(selectedTotal) }}</span>
            </div>

            <p
              v-if="selectedQuantity > remainingSlot"
              class="text-red-500 text-xl text-center mt-3"
            >
              Selected items exceed available slot
            </p>

            <button
              @click="goToCheckout"
              :disabled="!selectedCheckoutIds.length"
              class="mt-5 w-full bg-[var(--color-primary)] text-[var(--color-light)] py-3 rounded-xl text-xl font-bold hover:scale-[1.01] transition disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Proceed to Checkout
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <BackButton />
  <SlotIndicator />
</template>