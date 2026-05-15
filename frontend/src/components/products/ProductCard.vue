<script setup lang="ts">
import type { Product } from "@/types/product"
import { useRouter } from 'vue-router'

const formatPrice = (price: number) => {
  return `IDR ${(price / 1000).toFixed(0)}K`
}

const router = useRouter()

const props = defineProps({
  product: Object
})

const goToDetail = () => {

  // 🔥 cegah klik jika inactive
  if (!props.product?.is_active) return

  router.push(`/products/${props.product.id}`)
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
  <div class="flex flex-col gap-2 w-full">

    <div
      @click="goToDetail"
      class="relative transition"
      :class="
        product.is_active
          ? 'cursor-pointer hover:scale-103'
          : 'cursor-not-allowed opacity-60'
      "
    >

      <!-- CLOSED BADGE -->
      <div
        v-if="!product.is_active"
        class="
          absolute
          right-3
          top-3
          z-20
          rounded-full
          bg-[var(--color-primary)]
          px-4
          py-1
          text-sm
          font-bold
          uppercase
          tracking-wider
          text-[var(--color-light)]
          shadow-lg
        "
      >
        Closed
      </div>

      <!-- IMAGE -->
      <div class="rounded-xl overflow-hidden aspect-square shadow-sm">
        <img
          v-if="product.image_url"
          :src="imageUrl(product.image_url)"
          :alt="product.name"
          class="w-full h-full object-cover"
        />
      </div>

      <!-- NAME -->
      <p class="text-[var(--color-dark)] font-[LobsterFugu] text-2xl flex justify-center font-bold">
        {{ product.name.toUpperCase() }}
      </p>

      <!-- PRICE -->
      <p class="text-[var(--color-dark)] font-[LobsterFugu] text-2xl flex justify-center">
        {{ formatPrice(product.price) }}
      </p>

    </div>

  </div>
</template>