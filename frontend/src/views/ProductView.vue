<script setup lang="ts">
import { onMounted, onBeforeUnmount, ref, computed } from 'vue'
import { useProductStore } from '@/stores/productStore'
import ProductCard from '@/components/products/ProductCard.vue'
import { Search, ArrowLeft } from 'lucide-vue-next'
import BackButton from '@/components/ui/BackButton.vue'
import SlotIndicator from '@/components/ui/SlotIndicator.vue'

const productStore = useProductStore()
const searchQuery = ref('')
const categories = ref<string[]>([])
const selectedCategory = ref('')
const showDropdown = ref(false)

onMounted(() => {
  productStore.fetchProducts()
  fetchCategories()
  document.addEventListener('click', handleClickOutside)
})

onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside)
})

const filteredProducts = computed(() => {
  return productStore.products.filter((p) => {

    const matchSearch = p.name
      .toLowerCase()
      .includes(searchQuery.value.toLowerCase())

    const matchCategory =
    !selectedCategory.value ||
    selectedCategory.value === 'All' ||
    p.category === selectedCategory.value

    return matchSearch && matchCategory
  })
})

const fetchCategories = async () => {
  try {
    const res = await fetch('http://127.0.0.1:8000/api/categories')
    const data = await res.json()

    categories.value = ['All', ...data.map((c: any) => c.name)]
  } catch (error) {
    console.error('Gagal ambil kategori:', error)
  }
}

const selectCategory = (cat: string) => {
  selectedCategory.value = cat
  searchQuery.value = ''
  showDropdown.value = false
}

const handleClickOutside = (e: MouseEvent) => {
  const target = e.target as HTMLElement
  if (!target.closest('.relative')) {
    showDropdown.value = false
  }
}
</script>

<template>

  <div class="product-shell min-h-[calc(100vh-200px)] pt-20 pb-10 flex justify-center">

    <!-- CONTAINER -->
    <div class="max-w-7xl mx-auto w-full px-8 lg:px-16">
      <div class="space-y-12">
      <!-- TITLE -->
      <div class="flex justify-center">
        <h1 class="text-5xl font-bold text-[var(--color-dark)]">
          Price - List
        </h1>
      </div>

      <div class="sticky top-[80px] z-50 py-4 flex justify-center">
      <div class="relative w-full max-w-md">
        <div
          class="bg-[rgba(245,239,232,0.42)]
                backdrop-blur-xl
                border border-[rgba(255,255,255,0.55)]
                rounded-full px-4 py-3
                shadow-[0_10px_30px_rgba(40,0,0,0.12)]
                flex items-center"
        >
          <input
            v-model="searchQuery"
            @focus="showDropdown = true"
            type="text"
            placeholder="Search ..."
            class="flex-1 bg-transparent outline-none text-[var(--color-dark)] text-xl pb-1"
          />
          <Search class="text-[var(--color-dark)]" />
        </div>

    <!-- DROPDOWN -->
    <div
      v-if="showDropdown && categories.length"
      class="absolute top-full mt-2 w-full
            bg-[rgba(245,239,232,0.88)]
            backdrop-blur-xl
            border border-[rgba(255,255,255,0.5)]
            rounded-2xl shadow-[0_12px_30px_rgba(40,0,0,0.12)]
            z-50 overflow-hidden"
    >
      <div
        v-for="cat in categories"
        :key="cat"
        @click="selectCategory(cat)"
        class="px-4 py-2 hover:bg-pink-100 cursor-pointer text-[var(--color-dark)]"
      >
        {{ cat }}
      </div>
    </div>

  </div>
</div>
      <!-- LOADING -->
      <div v-if="productStore.loading" class="min-h-screen flex items-center justify-center">
        <p class="text-3xl text-[var(--color-dark)]">Loading...</p>
      </div>

      <!-- GRID -->
      <div
        v-else
        class="grid gap-6
        grid-cols-2
        sm:grid-cols-3
        md:grid-cols-4
        lg:grid-cols-5"
      >
        <ProductCard
          v-for="product in filteredProducts"
          :key="product.id"
          :product="product"
        />
      </div>
      </div>
    </div>

    <BackButton />
    <!-- SLOT -->
    <SlotIndicator />

  </div>
</template>