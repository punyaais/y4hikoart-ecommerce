<script setup lang="ts">
import NavBar from '@/components/NavBar.vue'
import ProductView from '@/views/ProductView.vue'
import Footer from '@/components/Footer.vue'
import { useRoute } from 'vue-router'
import { computed } from 'vue'

const route = useRoute()

const isAuthPage = computed(() => {
  return route.path === '/auth'
})
</script>

<template>
  <div class="flex flex-col min-h-screen">
    <NavBar v-if="!isAuthPage" />
    <main class="flex-1">
      <router-view />
    </main>
    <Footer v-if="!isAuthPage" />
  </div>
</template>