<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import axios from 'axios'

const total = ref(0)
const remaining = ref(0)
const loading = ref(true)

let interval: any = null

const fetchSlot = async () => {
  loading.value = true

  try {
    const res = await axios.get('http://127.0.0.1:8000/api/slots')

    console.log('SLOT:', res.data)

    total.value = res.data.total_slots
    remaining.value = res.data.remaining_slots
  } catch (err) {
    console.error('ERROR SLOT:', err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchSlot()
})

onUnmounted(() => {
  if (interval) clearInterval(interval)
})
</script>

<template>
  <div
    v-if="!loading"
    class="fixed right-6 top-[120px] z-50
           bg-[var(--color-secondary)]
           px-4 py-2 rounded-md shadow-md
           font-bold text-[var(--color-dark)]
           flex items-center gap-2"
  >
    <span class="text-xl uppercase pb-2">Slot</span>
    <span class="font-mono">
      ({{ remaining }}/{{ total }})
    </span>
  </div>
</template>