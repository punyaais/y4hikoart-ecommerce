<script setup lang="ts">
import { Twitter, Instagram, Mail } from 'lucide-vue-next'
</script>

<template>
  <footer class="bg-[var(--color-primary)] text-[var(--color-light)] flex flex-col">

    <!-- TOP NOTICE -->
    <div class="bg-[var(--color-soft)] text-[var(--color-dark)] text-2xl text-center py-3 px-4">
      Kindly check my gallery and terms before ordering, and feel free to DM me if you’re confused about the categories
    </div>

    <!-- MAIN FOOTER -->
    <div class="py-16 flex justify-center">
      <div class="w-full max-w-6xl px-6 flex flex-col items-center gap-6">

        <!-- LOGO -->
        <h2 class="text-3xl font-bold tracking-widest">
          Y4HIKOART
        </h2>

        <!-- MENU -->
        <div class="flex flex-wrap justify-center gap-10 gap-y-3 text-lg tracking-wide">
          <span class="hover:scale-120 transition cursor-pointer">HOME</span>
          <span class="hover:scale-120 transition cursor-pointer">SHOP</span>
          <span class="hover:scale-120 transition cursor-pointer">GALLERY</span>
          <span class="hover:scale-120 transition cursor-pointer">ORDER LIST</span>
        </div>

        <!-- DIVIDER -->
        <div class="border-t border-[var(--color-light)]/60 w-1/2"></div>

        <!-- SOCIAL -->
        <div class="flex justify-center gap-8">
          <Twitter class="w-5 h-5 hover:scale-110 transition cursor-pointer" />
          <Instagram class="w-5 h-5 hover:scale-110 transition cursor-pointer" />
          <Mail class="w-5 h-5 hover:scale-110 transition cursor-pointer" />
        </div>

        <!-- COPYRIGHT -->
        <p class="text-lg text-center leading-relaxed">
          © 2025 Y4HIKOART — Please don’t steal my art
        </p>

      </div>
    </div>

  </footer>
</template>