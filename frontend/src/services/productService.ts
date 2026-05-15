// // Mengambil instance Axios bernama api dari file api.ts
// import { api } from "./api"
// import type { Product } from "@/types/product"

// export const getProducts = async () => {
//   // const res = await api.get("/products")
//   const res = await api.get<{ data: Product[] }>("/products")
//   return res.data.data
// }

import { api } from "./api"
import type { Product } from "@/types/product"

export const getProducts = async (): Promise<Product[]> => {
  const res = await api.get("/products")

  console.log('API:', res.data)

  return res.data.data.map((item: any) => ({
    id: Number(item.id),
    name: item.name,
    description: item.description,
    price: item.price,
    category: item.category,
    image_url: item.image_url,
    is_active: item.is_active,
    created_at: item.created_at,
  }))
}