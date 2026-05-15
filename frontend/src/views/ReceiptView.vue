<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router'
import { ref, onMounted, onUnmounted, computed } from 'vue'
import axios from 'axios'
import { Check, ShoppingCart } from 'lucide-vue-next'

const route = useRoute()
const router = useRouter()
const orders = ref<any[]>([])

let interval: any = null

const fetchOrders = async () => {
  try {
    const orderIds = String(route.query.orders || '')
      .split(',')
      .filter(Boolean)

    const responses = await Promise.all(
      orderIds.map(id =>
        axios.get(`http://127.0.0.1:8000/api/orders/${id}`)
      )
    )

    orders.value = responses.map(res => res.data)

    // 🔥 STOP polling kalau sudah paid
    if (orders.value.every(order => order.payment?.payment_status === 'paid')) {
      clearInterval(interval)
    }

  } catch (err) {
    console.error('ERROR API:', err)
  }
}

onMounted(async () => {
  await fetchOrders()

  interval = setInterval(fetchOrders, 3000)
})

onUnmounted(() => {
  if (interval) clearInterval(interval)
})

const formatPrice = (price: number) => {
  return `IDR ${(price / 1000).toFixed(1)}K`
}

const grandTotal = computed(() => {
  return orders.value.reduce((sum, order) => {
    return sum + Number(order.total_price || 0)
  }, 0)
})

const isPaid = computed(() => {
  // 🔥 kalau habis dari xendit → langsung sukses
  if (isFromPayment.value) return true

  return orders.value.every(order => 
    order.payment?.payment_status === 'paid'
  )
})
const isFromPayment = computed(() => route.query.from_payment === '1')
const goToOrders = () => {
  router.push('/orders')
}
</script>

<template>
  <div class="receipt-shell min-h-[calc(100vh-200px)] pt-30 flex flex-col justify-end items-center">

    <div v-if="orders.length">

      <!-- ZIGZAG -->
      <div class="w-[470px] h-2 bg-[var(--color-light)] zigzag-top"></div>

      <!-- RECEIPT -->
      <div class="bg-[var(--color-light)] w-[470px] px-8 py-5
                  shadow-[0_-10px_20px_rgba(0,0,0,0.1)]
                  flex flex-col gap-6 mb-6">

        <!-- ICON -->
        <div class="flex justify-center">
          <div class="bg-[var(--color-primary)] w-16 h-16 rounded-full flex items-center justify-center shadow">
            <ShoppingCart class="w-7 h-7 text-[var(--color-light)]" />
          </div>
        </div>

        <!-- TITLE -->
        <h1 class="text-center text-4xl text-[var(--color-dark)]">
          Thanks for your order
        </h1>

        <!-- LINE -->
        <div class="border-t border-dashed border-[var(--color-dark)]"></div>

        <!-- ================= ORDER DETAILS ================= -->
        <div class="text-[var(--color-dark)] flex flex-col gap-2 font-mono">

          <p class="text-lg">Order Details</p>

          <div
            v-for="order in orders"
            :key="order.order_id"
            class="flex flex-col gap-1"
          >
            <!-- PRODUCT -->
            <div class="flex justify-between">
              <span>{{ order.product?.name }}</span>
              <span>
                {{ formatPrice(order.product?.price || 0) }}
              </span>
            </div>

            <!-- BACKGROUND -->
            <div
              v-for="char in order.characters || []"
              :key="char.character_id"
              class="flex justify-between"
            >
              <span>
                {{ char.background?.name || 'No background' }}
              </span>
              <span>
                {{ formatPrice(char.background?.price || 0) }}
              </span>
            </div>
          </div>

        </div>
        

        <!-- ================= INFO (TAMBAHAN KAMU) ================= -->
        <div class="flex flex-col gap-1 text-[var(--color-dark)] font-mono">

          <div class="flex flex-col gap-0.5">
            <p class="text-xl">Artist</p>
            <p>y4hikoart</p>
          </div>

          <div class="flex flex-col gap-0.5">
            <p class="text-xl">Email</p>
            <p>{{ orders[0]?.customer_email }}</p>
          </div>

          <div class="flex flex-col gap-0.5">
            <p class="text-xl">Payment Method</p>
            <p>{{ orders[0]?.payment?.payment_method || '-' }}</p>
          </div>

          <div class="flex flex-col gap-0.5">
            <p class="text-xl">Order Date</p>
            <p>{{ orders[0]?.order_date }}</p>
          </div>

        </div>
        <div class="text-center">
          <p v-if="isPaid" class="text-green-500 text-2xl font-bold">
            Payment Successful
          </p>

          <p v-else class="text-red-500 text-xl">
            Waiting for payment...
          </p>
        </div>

        <!-- LINE -->
        <div class="border-t border-dashed border-[var(--color-dark)]"></div>

        <!-- ================= TOTAL ================= -->
        <div class="flex justify-between text-xl text-[var(--color-dark)] font-mono">
          <span>Total</span>
          <span>
            {{ formatPrice(grandTotal) }}
          </span>
        </div>

        <!-- LINE -->
        <div class="border-t border-dashed border-[var(--color-dark)]"></div>

        <!-- BUTTON -->
        <button
          @click="goToOrders"
          class="w-full bg-[var(--color-secondary)] py-2 text-[var(--color-dark)] rounded-xl text-2xl shadow hover:scale-[1.03] transition"
        >
          View Orders
        </button>

        <!-- NOTE -->
        <p class="text-center text-xl text-[var(--color-dark)]">
          Note: Payment is due after sketch approval
        </p>

      </div>

    </div>

  </div>
</template>