<script setup lang="ts">
import { computed } from 'vue'

const user = computed(() => {
  const u = localStorage.getItem('user')
  return u ? JSON.parse(u) : null
})
</script>

<template>
  <nav class="fixed top-0 left-0 w-full z-50 bg-[var(--color-primary)] text-[var(--color-light)] px-10 py-4 flex items-center justify-between">
    
    <!-- Logo -->
    <h1 class="font-bold text-3xl tracking-widest">
      Y4HIKOART
    </h1>

    <!-- Menu -->
    <ul class="hidden md:flex gap-10 text-lg font-medium tracking-wide">
      <li><router-link to="/about">HOME</router-link></li>
      <li><router-link to="/shop">SHOP</router-link></li>
      <li><router-link to="/cart">CART</router-link></li>
      <li><router-link to="/orders">ORDER LIST</router-link></li>
    </ul>

    <!-- RIGHT SIDE -->
    <div class="flex gap-3 items-center">

      <!-- ❌ BELUM LOGIN -->
      <template v-if="!user">
        <router-link
          to="/auth?mode=login"
          class="border border-white px-5 py-1 rounded-lg hover:bg-white hover:text-pink-500"
        >
          SIGN-IN
        </router-link>

        <router-link
          to="/auth?mode=register"
          class="border border-white px-5 py-1 rounded-lg hover:bg-white hover:text-pink-500"
        >
          GET STARTED
        </router-link>
      </template>

      <!-- ✅ SUDAH LOGIN -->
      <template v-else>
        <router-link
          to="/profile"
          class="w-10 h-10 rounded-full bg-white text-pink-500 flex items-center justify-center hover:scale-105 transition"
        >
          {{ user.username.charAt(0).toUpperCase() }}
        </router-link>
      </template>

    </div>

  </nav>
</template>