<script setup lang="ts">
import { useRouter } from 'vue-router'
import { ArrowLeft } from 'lucide-vue-next'

const router = useRouter()

const goBack = () => {
  router.back()
}
</script>

<template>
  <button
    @click="goBack"
    class="fixed left-6 top-[100px] z-50 
           bg-[var(--color-secondary)] w-10 h-10
           flex items-center justify-center 
           rounded-md shadow-md
           hover:scale-110 transition cursor-pointer"
  >
    <ArrowLeft class="w-5 h-5 text-[var(--color-dark)]" />
  </button>
</template>