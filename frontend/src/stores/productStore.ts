import { defineStore } from "pinia"
import { getProducts } from "@/services/productService"
import type { Product } from "@/types/product"

export const useProductStore = defineStore("product", {
  state: () => ({
    products: [] as Product[],
    categories: [] as string[],
    loading: false
  }),

  actions: {
    async fetchProducts() {
      this.loading = true
      this.products = await getProducts()
      this.loading = false
    },
  }
})
