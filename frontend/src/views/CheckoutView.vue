<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router'
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'
import { Plus, X, ImagePlus, ChevronDown } from 'lucide-vue-next'
import BackButton from '@/components/ui/BackButton.vue'

const route = useRoute()
const router = useRouter()

const checkoutMode = computed(() => route.query.mode === 'cart')
const productId = Number(route.query.id)
const quantity = Number(route.query.qty || 1)

const loading = ref(true)
const cart = ref<any>(null)

const name = ref('')
const email = ref('')
const agreeTerms = ref(false)

type ImageItem = {
  file: File
  preview: string
}

type CharacterForm = {
  open: boolean
  category: string
  detail: string
  background_category: string
  background_id: number | null
  background_detail: string
  extra_price: number
  images: ImageItem[]
}

type CheckoutBlock = {
  key: string
  product: any
  quantity: number
  backgrounds: any[]
  open: boolean
  cart_item_id?: number | null
  characters: CharacterForm[]
}

const createCharacter = (open = false): CharacterForm => ({
  open,
  category: 'original',
  detail: '',
  background_category: 'none',
  background_id: null,
  background_detail: '',
  extra_price: 0,
  images: []
})

const createBlock = (
  productData: any,
  qty: number,
  backgroundsData: any[],
  open = false,
  cartItemId: number | null = null
): CheckoutBlock => ({
  key: `${productData.product_id ?? productData.id}-${Math.random().toString(36).slice(2)}`,
  product: productData,
  quantity: qty,
  backgrounds: backgroundsData,
  open,
  cart_item_id: cartItemId,
  characters: Array.from(
    { length: qty * Number(productData.character_required || 1) },
    (_, idx) => createCharacter(open && idx === 0)
  )
})

const checkoutBlocks = ref<CheckoutBlock[]>([])

const fetchCheckoutData = async () => {
  loading.value = true

  try {
    if (checkoutMode.value) {
      const cartRes = await axios.get('http://127.0.0.1:8000/api/cart')
      cart.value = cartRes.data

      const selectedIds = String(route.query.selected || '')
        .split(',')
        .filter(Boolean)
        .map(id => Number(id))

      const items = (cart.value?.items || []).filter((item: any) =>
        selectedIds.length ? selectedIds.includes(item.id) : true
      )

      const blocks = await Promise.all(
        items.map(async (item: any, index: number) => {
          const pid = item.product?.product_id ?? item.product_id ?? item.product?.id
          const qty = Number(item.quantity || 1)

          const res = await axios.get(`http://127.0.0.1:8000/api/products/${pid}`)
          return createBlock(res.data.product, qty, res.data.backgrounds || [], index === 0, item.id)
        })
      )

      checkoutBlocks.value = blocks
    } else {
      const res = await axios.get(`http://127.0.0.1:8000/api/products/${productId}`)
      checkoutBlocks.value = [
        createBlock(res.data.product, quantity, res.data.backgrounds || [], true)
      ]
    }
  } catch (err) {
    console.error('ERROR FETCH CHECKOUT DATA:', err)
  } finally {
    loading.value = false
  }
}

onMounted(fetchCheckoutData)

const formatPrice = (price: number) => {
  return `IDR ${(price / 1000).toFixed(0)}K`
}

const btnSelect = (active: boolean) => {
  return [
    'px-4 pb-2 rounded-full border text-xl transition',
    'border-[var(--color-1)] text-[var(--color-dark)]',
    active ? 'bg-[var(--color-soft)]' : 'bg-transparent hover:bg-[var(--color-soft)]/30'
  ]
}

const toggleBlock = (blockIndex: number) => {
  const block = checkoutBlocks.value[blockIndex]
  if (block) {
    block.open = !block.open
  }
}

const toggleChar = (blockIndex: number, charIndex: number) => {
  const block = checkoutBlocks.value[blockIndex]
  const character = block?.characters[charIndex]
  if (!character) return

  character.open = !character.open
}

const handleImageUpload = (event: Event, blockIndex: number, charIndex: number) => {
  const files = (event.target as HTMLInputElement).files
  if (!files) return

  const block = checkoutBlocks.value[blockIndex]
  const character = block?.characters[charIndex]
  if (!character) return

  Array.from(files).forEach(file => {
    character.images.push({
      file,
      preview: URL.createObjectURL(file)
    })
  })
}

const removeImage = (blockIndex: number, charIndex: number, imgIndex: number) => {
  const block = checkoutBlocks.value[blockIndex]
  const character = block?.characters[charIndex]
  if (!character) return

  character.images.splice(imgIndex, 1)
}

const getBackgroundName = (block: CheckoutBlock, bgId: number | null) => {
  if (!bgId) return ''
  const bg = block.backgrounds.find(b => b.id === bgId)
  return bg ? bg.name : ''
}

const getBackgroundPrice = (block: CheckoutBlock, bgId: number | null) => {
  const bg = block.backgrounds.find(b => b.id === bgId)
  return bg ? bg.price : 0
}

const itemTotal = (block: CheckoutBlock) => {
  return (
    Number(block.product.price || 0) * Number(block.quantity || 1) +
    block.characters.reduce((sum, char) => {
      return sum + getBackgroundPrice(block, char.background_id) + Number(char.extra_price || 0)
    }, 0)
  )
}

const grandTotal = computed(() => {
  return checkoutBlocks.value.reduce((sum, block) => sum + itemTotal(block), 0)
})

const summaryItems = computed(() => {
  const items: { name: string; price: number }[] = []

  checkoutBlocks.value.forEach(block => {
    items.push({
      name: `${block.quantity} x ${String(block.product.name).toUpperCase()}`,
      price: Number(block.product.price || 0) * Number(block.quantity || 1)
    })

    block.characters.forEach(char => {
      if (char.background_id) {
        items.push({
          name: `1 x ${getBackgroundName(block, char.background_id)}`,
          price: getBackgroundPrice(block, char.background_id)
        })
      }
    })
  })

  return items
})

const isFormValid = computed(() => {
  if (!name.value || !email.value) return false
  if (!selectedPayment.value) return false
  if (!agreeTerms.value) return false

  for (const block of checkoutBlocks.value) {
    for (const char of block.characters) {
      if (!char.category) return false
      if (!char.detail) return false
      if (!char.background_id) return false
      if (!char.background_detail) return false
      if (!char.images.length) return false
    }
  }

  return true
})

const submitOrder = async () => {
  if (!isFormValid.value) {
    alert('Harap lengkapi semua form terlebih dahulu!')
    return
  }

  try {
    const createdOrderIds: number[] = []

    // ================== 1. CREATE ORDER DULU ==================
    for (const block of checkoutBlocks.value) {
      const formData = new FormData()

      if (checkoutMode.value && block.cart_item_id) {
        formData.append('cart_item_id', String(block.cart_item_id))
      }

      formData.append('product_id', String(block.product.product_id ?? block.product.id))
      formData.append('quantity', String(block.quantity))
      formData.append('name', name.value)
      formData.append('email', email.value)
      formData.append('payment_method', selectedPayment.value || '')

      block.characters.forEach((char, i) => {
        formData.append(`characters[${i}][category]`, char.category)
        formData.append(`characters[${i}][detail]`, char.detail)
        formData.append(
          `characters[${i}][background_category]`,
          char.background_category
        )
        formData.append(`characters[${i}][background_id]`, String(char.background_id ?? ''))
        formData.append(`characters[${i}][background_detail]`, char.background_detail)
        formData.append(`characters[${i}][extra_price]`, String(char.extra_price))

        char.images.forEach((img: any) => {
          formData.append(`characters[${i}][images][]`, img.file)
        })
      })

      const res = await axios.post(
        'http://127.0.0.1:8000/api/orders',
        formData,
        { headers: { 'Content-Type': 'multipart/form-data' } }
      )

      createdOrderIds.push(res.data.order_id)
    }

    // ================== 2. PAYMENT ==================

    if (selectedPayment.value === 'later') {
      router.push({
        path: '/receipt',
        query: { orders: createdOrderIds.join(',') }
      })
      return
    }

    if (selectedPayment.value === 'now') {
      const res = await axios.post(
        'http://127.0.0.1:8000/api/payment/xendit',
        {
          order_ids: createdOrderIds,
          email: email.value
        }
      )

      // ✅ redirect ke Xendit
      window.location.href = res.data.invoice_url
    }

  } catch (err: any) {
    console.error(err)

    alert(
      err?.response?.data?.message ||
      err?.response?.data?.error ||
      'Gagal checkout'
    )
  }
}
const selectedPayment = ref<'now' | 'later' | null>(null)
</script>

<template>
  <div class="checkout-shell min-h-screen py-10 flex justify-center">
    <div class="max-w-6xl w-full px-4 pt-20 flex flex-col gap-5">
      <div class="bg-[var(--color-light)] p-6 rounded-xl shadow text-center text-3xl font-bold text-[var(--color-dark)]">
        Review Your Order Before Checkout
      </div>

      <div v-if="loading" class="text-center py-20">
        Loading...
      </div>

      <template v-else>
        <!-- CUSTOMER INFO -->
        <div class="bg-[var(--color-light)] p-5 rounded-xl shadow flex flex-col gap-4 border border-[var(--color-soft)]/40">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <input
              v-model="name"
              placeholder="Name"
              class="px-2 pb-1 input text-[var(--color-dark)] text-2xl focus:outline-none focus:border-[var(--color-soft)] hover:bg-pink-50 transition"
            />
            <input
              v-model="email"
              placeholder="Email"
              class="px-2 pb-1 input text-[var(--color-dark)] text-2xl focus:outline-none focus:border-[var(--color-soft)] hover:bg-pink-50 transition"
            />
          </div>
        </div>

        <!-- PRODUCT BLOCKS -->
        <div class="flex flex-col gap-4">
          <div
            v-for="(block, blockIndex) in checkoutBlocks"
            :key="block.key"
            class="bg-[var(--color-light)] rounded-xl border border-[var(--color-soft)]/40 shadow-sm overflow-hidden"
          >
            <button
              @click="toggleBlock(blockIndex)"
              class="w-full px-5 py-4 flex justify-between items-center gap-4 text-left"
            >
              <div class="flex flex-col min-w-0">
                <h2 class="font-bold text-[var(--color-dark)] text-2xl md:text-3xl uppercase truncate">
                  {{ block.quantity }} x {{ block.product.name }}
                </h2>
                <span class="text-sm md:text-base text-[var(--color-dark)]/70">
                  {{ block.characters.length }} character reference
                </span>
              </div>

              <div class="flex items-center gap-3 shrink-0">
                <span class="text-2xl font-mono text-[var(--color-dark)]">
                  {{ formatPrice(itemTotal(block)) }}
                </span>
                <ChevronDown
                  class="w-5 h-5 text-[var(--color-dark)] transition-transform duration-300"
                  :class="{ 'rotate-180': block.open }"
                />
              </div>
            </button>

            <div v-if="block.open" class="px-5 pb-5 pt-2 flex flex-col gap-4 border-t border-[var(--color-soft)]/30">
              <div
                v-for="(char, charIndex) in block.characters"
                :key="charIndex"
                class="bg-[var(--color-light)] rounded-xl border border-[var(--color-soft)]/50 shadow-sm overflow-hidden"
              >
                <button
                  @click="toggleChar(blockIndex, charIndex)"
                  class="w-full px-4 py-3 flex justify-between items-center text-left bg-[var(--color-light)]/90 hover:bg-[var(--color-soft)]/10 transition"
                >
                  <h3 class="font-bold text-[var(--color-dark)] text-xl md:text-2xl">
                    Character Reference {{ charIndex + 1 }}
                  </h3>

                  <ChevronDown
                    class="w-5 h-5 text-[var(--color-dark)] transition-transform duration-300"
                    :class="{ 'rotate-180': char.open }"
                  />
                </button>

                <div v-if="char.open" class="p-4 md:p-5 border-t border-[var(--color-soft)]/30 flex flex-col gap-4">
                  <div class="flex flex-col gap-3">
                    <div class="section-title bg-[var(--color-primary)] text-[var(--color-light)] rounded-md w-fit px-3 pb-1 text-xl">
                      Select Character Type
                    </div>

                    <div class="flex gap-3 flex-wrap">
                      <button @click="char.category = 'original'" :class="btnSelect(char.category === 'original')">
                        Original Character
                      </button>
                      <button @click="char.category = 'fanart'" :class="btnSelect(char.category === 'fanart')">
                        Fanart
                      </button>
                    </div>
                  </div>

                  <div class="flex flex-col gap-3">
                    <div class="section-title bg-[var(--color-primary)] text-[var(--color-light)] rounded-md w-fit px-3 pb-1 text-xl">
                      Add Reference Details
                    </div>

                    <div class="flex gap-4 items-start">
                      <label class="w-15 h-50 border-2 border-dashed border-[var(--color-soft)] rounded-md flex items-center justify-center cursor-pointer hover:bg-pink-50 transition">
                        <input
                          type="file"
                          multiple
                          class="hidden"
                          @change="handleImageUpload($event, blockIndex, charIndex)"
                        />
                        <Plus class="w-6 h-6 text-pink-400" />
                      </label>

                      <div class="flex-1">
                        <label
                          v-if="!char.images.length"
                          class="w-50 h-50 border-2 border-dashed border-[var(--color-soft)] rounded-md flex flex-col items-center justify-center cursor-pointer hover:bg-pink-50 transition"
                        >
                          <input
                            type="file"
                            multiple
                            class="hidden"
                            @change="handleImageUpload($event, blockIndex, charIndex)"
                          />

                          <div class="text-[var(--color-primary)] flex flex-col items-center">
                            <ImagePlus class="w-5 h-5 mb-1" />
                            <span class="text-xl">Upload Reference Image</span>
                          </div>
                        </label>

                        <div v-else class="flex gap-3 flex-wrap">
                          <div
                            v-for="(img, imgIndex) in char.images"
                            :key="imgIndex"
                            class="w-50 h-50 relative"
                          >
                            <img :src="img.preview" class="w-full h-full object-cover rounded-xl" />

                            <button
                              @click="removeImage(blockIndex, charIndex, imgIndex)"
                              class="absolute -top-2 -right-2 bg-[var(--color-primary)] text-[var(--color-light)] w-6 h-6 rounded-full flex items-center justify-center shadow"
                            >
                              <X class="w-3 h-3" />
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <textarea
                    v-model="char.detail"
                    placeholder="Add Description..."
                    class="input text-[var(--color-dark)] border border-[var(--color-soft)] focus:outline-none focus:border-[var(--color-soft)] hover:bg-pink-50 transition w-full rounded-md text-xl px-2 py-2"
                  ></textarea>

                  <div class="flex flex-col gap-3">
                    <div class="section-title bg-[var(--color-primary)] text-[var(--color-light)] rounded-md w-fit px-3 pb-1 text-xl">
                      Select Background
                    </div>

                    <div class="flex gap-3 flex-wrap">
                      <button
                        v-for="bg in block.backgrounds"
                        :key="bg.id"
                        @click="
                          char.background_id = bg.id;

                          char.background_category =
                            bg.name.toLowerCase().includes('simple')
                              ? 'simple'
                              : bg.name.toLowerCase().includes('detailed')
                              ? 'detailed'
                              : 'none';
                        "
                        :class="btnSelect(char.background_id === bg.id)"
                      >
                        {{ bg.name }} (+{{ formatPrice(bg.price) }})
                      </button>
                    </div>
                  </div>

                  <textarea
                    v-model="char.background_detail"
                    placeholder="Describe the background..."
                    class="input text-[var(--color-dark)] border border-[var(--color-soft)] focus:outline-none focus:border-[var(--color-soft)] hover:bg-pink-50 transition w-full rounded-md text-xl px-2 py-2"
                  ></textarea>
                </div>
              </div>

              <div class="border-t border-[var(--color-soft)]/30 pt-4 flex justify-between items-center text-2xl md:text-3xl font-bold text-[var(--color-dark)]">
                <span>Subtotal item</span>
                <span class="font-mono">{{ formatPrice(itemTotal(block)) }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- PAYMENT METHOD -->
        <div class="bg-[var(--color-light)] p-5 rounded-xl shadow flex flex-col gap-3 border border-[var(--color-soft)]/40">
          <h2 class="font-bold text-3xl text-[var(--color-dark)]">
            Payment Method
          </h2>

          <div class="flex gap-3 flex-wrap">
            <button @click="selectedPayment = 'now'" :class="btnSelect(selectedPayment === 'now')">
              Pay Now
            </button>

            <button @click="selectedPayment = 'later'" :class="btnSelect(selectedPayment === 'later')">
              Pay Later
            </button>
          </div>
        </div>

        <!-- TERMS -->
        <div class="bg-[var(--color-light)] p-6 rounded-xl shadow flex items-center gap-3 border border-[var(--color-soft)]/40">
          <input
            type="checkbox"
            v-model="agreeTerms"
            class="w-6 h-6 accent-[var(--color-primary)] cursor-pointer"
          />
          <span class="pb-1 text-2xl text-[var(--color-dark)]">
            I agree to the terms and conditions
          </span>
        </div>

        <!-- ORDER SUMMARY -->
        <div class="bg-[var(--color-light)] p-5 rounded-xl shadow flex flex-col gap-3 border border-[var(--color-soft)]/40">
          <div class="text-2xl font-bold text-[var(--color-dark)]">
            Order Summary
          </div>

          <div class="flex flex-col gap-2 text-[var(--color-dark)] text-xl">
            <div
              v-for="(item, index) in summaryItems"
              :key="index"
              class="flex justify-between gap-4"
            >
              <span class="min-w-0 truncate">
                {{ item.name }}
              </span>
              <span class="font-mono shrink-0">
                {{ formatPrice(item.price) }}
              </span>
            </div>
          </div>

          <div class="border-t border-[var(--color-soft)]/40 my-2"></div>

          <div class="flex justify-between items-center text-3xl font-bold text-[var(--color-dark)]">
            <span>Total</span>
            <span class="font-mono">{{ formatPrice(grandTotal) }}</span>
          </div>

          <p v-if="!isFormValid" class="text-red-500 text-xl flex justify-center">
            Please complete all required fields first
          </p>

          <button
            @click="submitOrder"
            class="w-full bg-[var(--color-primary)] text-[var(--color-light)] py-2 rounded-xl font-semibold transition text-2xl disabled:opacity-50 disabled:cursor-not-allowed hover:scale-[1.02]"
          >
            Checkout
          </button>
        </div>
      </template>
    </div>
  </div>

  <BackButton />
</template>