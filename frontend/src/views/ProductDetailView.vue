<script setup lang="ts">
import { onMounted, ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useProductStore } from '@/stores/productStore'
import { Minus, Plus, ShoppingCart } from 'lucide-vue-next'
import BackButton from '@/components/ui/BackButton.vue'
import SlotIndicator from '@/components/ui/SlotIndicator.vue'
import axios from 'axios'

const route = useRoute()
const router = useRouter()
const productStore = useProductStore()
const remainingSlot = ref(0)

const productId = Number(route.params.id)

onMounted(() => {
  if (!productStore.products.length) {
    productStore.fetchProducts()
  }

  fetchSlot()
})

const product = computed(() =>
  productStore.products.find(p => p.id === productId)
)

const quantity = ref(1)

const fetchSlot = async () => {
  try {
    const res = await axios.get('http://127.0.0.1:8000/api/slots')
    remainingSlot.value = res.data.remaining_slots ?? 0
  } catch (err) {
    console.error('ERROR SLOT:', err)
  }
}

const increase = () => {
  if (quantity.value < remainingSlot.value) {
    quantity.value++
  }
}
const decrease = () => {
  if (quantity.value > 1) {
    quantity.value--
  }
}

const goToCheckout = () => {
  if (quantity.value > remainingSlot.value) {
    alert('Quantity exceeds available slot')
    return
  }

  router.push({
    path: '/checkout',
    query: {
      id: product.value?.id,
      qty: quantity.value
    }
  })
}
const formatPrice = (price: number) => {
  return `IDR ${(price / 1000).toFixed(0)}K`
}
const addToCart = async () => {
  try {
    const token = localStorage.getItem('token')

    await axios.post(
      'http://127.0.0.1:8000/api/cart/add',
      {
        product_id: product.value?.id,
        quantity: quantity.value
      },
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )

    // redirect setelah sukses
    router.push('/cart')

  } catch (err: any) {
    console.error(err)
    alert('Gagal tambah ke cart')
  }
}
const imageUrl = (path?: string) => {
  if (!path) return ''

  if (path.startsWith('http')) {
    return path
  }

  return `http://127.0.0.1:8000${path}`
}
</script>

<template>
  <div class="product-detail-shell pt-32 pb-16 flex justify-center">

    <div class="max-w-7xl mx-auto w-full px-6 lg:px-16">

      <div v-if="product" class="grid md:grid-cols-[0.8fr_1.4fr] gap-20 items-start">

        <!-- IMAGE -->
        <div class="flex justify-left">
            <div class="w-[500px] max-w-sm aspect-square rounded-xl overflow-hidden shadow-sm">
            <img
              :src="imageUrl(product.image_url)"
              :alt="product.name"
              class="w-full h-full object-cover"
            />
            </div>
        </div>

        <!-- DETAIL -->
        <div class="h-full flex flex-col justify-between">

            <!-- TOP CONTENT -->
            <div class="space-y-10">

            <h1 class="text-3xl md:text-4xl font-bold text-[var(--color-dark)] pb-2">
                {{ product.name.toUpperCase() }}
            </h1>

            <p class="text-3xl font-semibold text-[var(--color-dark)] pb-5">
                {{ formatPrice(product.price) }} / character
            </p>

            <div class="max-h-[20vh] overflow-y-auto pr-2 scroll-smooth">
            <p class="text-2xl text-[var(--color-dark)] leading-[1.6] text-justify">
                {{ product.description }}
            </p>
            </div>

            </div>

            <!-- BOTTOM ACTION -->
            <div class="flex items-center justify-end gap-4">

            <!-- QUANTITY -->
            <div class="flex items-center border rounded-lg border-[var(--color-primary)] overflow-hidden bg-[var(--color-light)]">

                <button
                  @click="decrease"
                  :disabled="quantity <= 1"
                  class="w-10 h-10 flex items-center justify-center hover:bg-pink-100 disabled:opacity-40 disabled:cursor-not-allowed"
                >
                <Minus class="w-4 h-4 text-[var(--color-dark)] hover:scale-120 transition cursor-pointer"/>
                </button>

                <span class="w-12 pb-2 text-center text-2xl text-[var(--color-dark)] font-semibold">
                {{ quantity }}
                </span>

                <button
                  @click="increase"
                  :disabled="quantity >= remainingSlot"
                  class="w-10 h-10 flex items-center justify-center hover:bg-pink-100 disabled:opacity-40 disabled:cursor-not-allowed"
                >
                <Plus class="w-4 h-4 text-[var(--color-dark)] hover:scale-120 transition cursor-pointer"/>
                </button>
            </div>


            <!-- CHECKOUT -->
            
            <button 
                @click="addToCart"
                class="bg-[var(--color-secondary)] w-12 h-12 flex items-center justify-center rounded-lg shadow hover:scale-105 transition"
            >
              <ShoppingCart class="w-5 h-5 text-[var(--color-dark)]"/>
            </button>
            <button
                @click="goToCheckout"
                class="bg-[var(--color-secondary)] text-2xl text-[var(--color-dark)] px-3 py-2 pb-4 h-12 flex items-center justify-center rounded-lg shadow hover:scale-105 transition"
            >
                checkout
            </button>

            </div>

        </div>

        </div>
        <div v-if="productStore.loading" class="min-h-screen flex items-center justify-center">
        <p class="text-3xl text-[var(--color-dark)]">Loading...</p>
        </div>
        
    <BackButton />
    <SlotIndicator />

    </div>
  </div>
</template>