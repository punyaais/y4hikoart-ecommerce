<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import {
  BadgeCheck,
  CalendarDays,
  ChevronDown,
  LogOut,
  PencilLine,
  Palette,
  ShoppingBag,
  ShieldCheck,
  Sparkles,
  UserRound,
  Mail,
  AtSign
} from 'lucide-vue-next'

type User = {
  id: number
  name: string
  username: string
  email: string
}

type Order = {
  order_id: number
  user_id: number
  customer_name?: string
  customer_email?: string
  total_price?: number
  order_date?: string
  created_at?: string
  payment?: {
    payment_status?: string
    payment_method?: string
  }
  product?: {
    name?: string
    image_url?: string
  }
  characters?: Array<{
    character_id: number
    character_category?: string
    character_detail?: string
    background?: {
      name?: string
    }
  }>
}

type CoverTheme = {
  key: string
  label: string
  base: string
  pattern: string
  patternSize: string
}

const router = useRouter()

const authUser = ref<User | null>(null)
const orders = ref<Order[]>([])
const loading = ref(true)
const saving = ref(false)
const editing = ref(false)
const expandedOrderId = ref<number | null>(null)

const formName = ref('')
const formUsername = ref('')
const formEmail = ref('')
const usernameError = ref('')
const emailError = ref('')
const generalError = ref('')

const coverThemes: CoverTheme[] = [
  {
    key: 'blush-dots',
    label: 'Blush Dots',
    base: '#FDE8F1',
    pattern:
      'radial-gradient(circle at 12px 12px, rgba(246, 55, 143, 0.18) 2px, transparent 2.5px), radial-gradient(circle at 36px 36px, rgba(48, 52, 129, 0.12) 1.5px, transparent 2px)',
    patternSize: '48px 48px, 72px 72px'
  },
  {
    key: 'cream-bubbles',
    label: 'Cream Bubbles',
    base: '#F8EFE7',
    pattern:
      'radial-gradient(circle at 14px 14px, rgba(142, 165, 235, 0.22) 2px, transparent 2.5px), radial-gradient(circle at 44px 44px, rgba(255, 221, 0, 0.18) 1.5px, transparent 2px)',
    patternSize: '52px 52px, 84px 84px'
  },
  {
    key: 'soft-tiles',
    label: 'Soft Tiles',
    base: '#FBE5EC',
    pattern:
      'repeating-linear-gradient(45deg, rgba(246, 55, 143, 0.08) 0 10px, rgba(255, 255, 255, 0.02) 10px 20px), radial-gradient(circle at 16px 16px, rgba(48, 52, 129, 0.10) 1.5px, transparent 2px)',
    patternSize: 'auto, 44px 44px'
  },
  {
    key: 'sky-sprinkles',
    label: 'Sky Sprinkles',
    base: '#EAF1FF',
    pattern:
      'radial-gradient(circle at 10px 10px, rgba(48, 52, 129, 0.13) 2px, transparent 2.5px), radial-gradient(circle at 30px 30px, rgba(246, 55, 143, 0.10) 1.5px, transparent 2px)',
    patternSize: '44px 44px, 68px 68px'
  }
]

const selectedCover = ref(localStorage.getItem('profile_cover') || coverThemes[0].key)

const currentUser = computed<User | null>(() => {
  if (authUser.value) return authUser.value

  const raw = localStorage.getItem('user')
  if (!raw) return null

  try {
    return JSON.parse(raw)
  } catch {
    return null
  }
})

const initials = computed(() => {
  const source = currentUser.value?.username || currentUser.value?.name || 'U'
  const cleaned = source
    .trim()
    .split(/\s+/)
    .map(part => part[0] || '')
    .join('')
    .slice(0, 2)
    .toUpperCase()

  return cleaned || 'U'
})

const avatarColor = computed(() => {
  const palette = ['#F6378F', '#303481', '#FFDD00', '#8EA5EB', '#FF8A5B', '#A855F7']
  const seed = currentUser.value?.username || currentUser.value?.email || 'user'
  const index = seed.split('').reduce((sum, char) => sum + char.charCodeAt(0), 0) % palette.length
  return palette[index]
})

const coverTheme = computed(() => {
  return coverThemes.find(item => item.key === selectedCover.value) || coverThemes[0]
})

const coverStyle = computed(() => {
  return {
    backgroundColor: coverTheme.value.base,
    backgroundImage: coverTheme.value.pattern,
    backgroundSize: coverTheme.value.patternSize
  }
})

const editCoverStyle = (theme: CoverTheme) => {
  return {
    backgroundColor: theme.base,
    backgroundImage: theme.pattern,
    backgroundSize: theme.patternSize
  }
}

const formatPrice = (price: number) => {
  return `IDR ${(Number(price || 0) / 1000).toFixed(0)}K`
}

const formatDate = (dateValue?: string) => {
  if (!dateValue) return '-'

  const date = new Date(dateValue)
  if (Number.isNaN(date.getTime())) return dateValue

  return date.toLocaleDateString('en-US', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  })
}

const statusLabel = (status?: string) => {
  const value = String(status || 'pending').toLowerCase()

  if (value === 'paid') return 'Paid'
  if (value === 'expired') return 'Expired'
  if (value === 'pending') return 'Pending'
  return value
}

const statusClass = (status?: string) => {
  const value = String(status || 'pending').toLowerCase()

  if (value === 'paid') {
    return 'bg-emerald-100 text-emerald-700 border-emerald-200'
  }

  if (value === 'expired') {
    return 'bg-rose-100 text-rose-700 border-rose-200'
  }

  return 'bg-amber-100 text-amber-700 border-amber-200'
}

const stats = computed(() => {
  const totalOrders = orders.value.length
  const paidOrders = orders.value.filter(order => order.payment?.payment_status === 'paid').length
  const pendingOrders = orders.value.filter(order => order.payment?.payment_status === 'pending').length
  const totalSpent = orders.value.reduce((sum, order) => sum + Number(order.total_price || 0), 0)

  return [
    {
      label: 'Orders',
      value: totalOrders,
      icon: ShoppingBag
    },
    {
      label: 'Paid',
      value: paidOrders,
      icon: BadgeCheck
    },
    {
      label: 'Pending',
      value: pendingOrders,
      icon: ShieldCheck
    },
    {
      label: 'Spent',
      value: formatPrice(totalSpent),
      icon: Sparkles
    }
  ]
})

const visibleOrders = computed(() => {
  return [...orders.value].sort((a, b) => Number(b.order_id) - Number(a.order_id))
})

const openEditModal = () => {
  usernameError.value = ''
  emailError.value = ''
  generalError.value = ''
  editing.value = true

  formName.value = currentUser.value?.name || ''
  formUsername.value = currentUser.value?.username || ''
  formEmail.value = currentUser.value?.email || ''
}

const saveProfile = async () => {
  usernameError.value = ''
  emailError.value = ''
  generalError.value = ''
  saving.value = true

  try {
    const res = await axios.put('/profile', {
      name: formName.value.trim(),
      username: formUsername.value.trim(),
      email: formEmail.value.trim()
    })

    authUser.value = res.data.user
    localStorage.setItem('user', JSON.stringify(res.data.user))
    editing.value = false
  } catch (err: any) {
    const response = err?.response?.data
    usernameError.value = response?.errors?.username?.[0] || ''
    emailError.value = response?.errors?.email?.[0] || ''
    generalError.value = response?.message || response?.error || 'Failed to update profile'
  } finally {
    saving.value = false
  }
}

const setCover = (key: string) => {
  selectedCover.value = key
  localStorage.setItem('profile_cover', key)
}

const toggleOrder = (orderId: number) => {
  expandedOrderId.value = expandedOrderId.value === orderId ? null : orderId
}

const logout = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('user')
  router.push('/auth?mode=login')
}

const loadProfile = async () => {
  loading.value = true
  generalError.value = ''

  try {
    const [meResult, ordersResult] = await Promise.allSettled([
      axios.get('/me'),
      axios.get('/me/orders')
    ])

    if (meResult.status === 'fulfilled') {
      authUser.value = meResult.value.data
      localStorage.setItem('user', JSON.stringify(meResult.value.data))
    } else {
      const raw = localStorage.getItem('user')
      authUser.value = raw ? JSON.parse(raw) : null
    }

    if (ordersResult.status === 'fulfilled') {
      orders.value = Array.isArray(ordersResult.value.data) ? ordersResult.value.data : []
    } else {
      orders.value = []
    }
  } catch (err: any) {
    generalError.value = err?.response?.data?.message || 'Failed to load profile'
  } finally {
    loading.value = false
  }
}

watch(selectedCover, (value) => {
  localStorage.setItem('profile_cover', value)
})

onMounted(loadProfile)
</script>

<template>
  <div class="min-h-screen profile-shell pt-28 pb-10 px-4 relative overflow-hidden flex justify-center">
    <!-- BACKGROUND -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-24 top-16 h-72 w-72 rounded-full bg-[var(--color-primary)]/10 blur-3xl"></div>
      <div class="absolute right-0 top-36 h-80 w-80 rounded-full bg-[var(--color-soft)]/15 blur-3xl"></div>
      <div class="absolute left-1/3 bottom-0 h-72 w-72 rounded-full bg-[var(--color-secondary)]/10 blur-3xl"></div>
    </div>

    <!-- 🔥 GRID UTAMA -->
    <div class="relative z-10 mx-auto max-w-7xl grid xl:grid-cols-[260px_1fr] gap-6">

      <!-- ================= SIDEBAR ================= -->
      <aside class="hidden xl:block sticky top-28 h-fit">
  <div class="bg-[var(--color-light)] rounded-[26px] p-5 shadow flex flex-col gap-6">

    <!-- USER -->
    <div class="flex items-center gap-4">
      <div
        class="w-14 h-14 flex items-center justify-center text-[var(--color-light)] font-bold text-2xl pb-2
        rounded-[35%_65%_60%_40%/50%_40%_60%_50%] bg-[var(--color-primary)]"
      >
        {{ initials }}
      </div>

      <div class="min-w-0">
        <p class="font-bold text-[var(--color-dark)] truncate">
          {{ currentUser?.username }}
        </p>
        <p class="text-xl text-[var(--color-dark)]/60 truncate">
          {{ currentUser?.email }}
        </p>
      </div>
    </div>

    <!-- DASHBOARD MENU -->
    <div class="flex flex-col gap-4">

      <!-- ORDERS -->
      <div
        @click="$router.push('/orders')"
        class="flex items-center gap-3 p-3 rounded-xl hover:bg-[var(--color-cream)] cursor-pointer transition"
      >
        <ShoppingBag class="w-5 h-5 text-[var(--color-primary)]" />
        <span class="font-medium text-[var(--color-dark)]">My Orders</span>
      </div>

      <!-- CART -->
      <div
        @click="$router.push('/cart')"
        class="flex items-center gap-3 p-3 rounded-xl hover:bg-[var(--color-cream)] cursor-pointer transition"
      >
        <ShoppingBag class="w-5 h-5 text-[var(--color-primary)]" />
        <span class="font-medium text-[var(--color-dark)]">Cart</span>
      </div>

      <!-- SETTINGS -->
      <div
        @click="openEditModal"
        class="flex items-center gap-3 p-3 rounded-xl hover:bg-[var(--color-cream)] cursor-pointer transition"
      >
        <ShieldCheck class="w-5 h-5 text-[var(--color-primary)]" />
        <span class="font-medium text-[var(--color-dark)]">Settings</span>
      </div>

    </div>

    <div class="border-t border-[var(--color-soft)]/30"></div>

    <!-- LOGOUT -->
    <button
      @click="logout"
      class="bg-[var(--color-primary)] text-[var(--color-light)] py-3 rounded-xl font-semibold flex items-center justify-center gap-2 hover:scale-[1.02] transition"
    >
      <LogOut class="w-5 h-5" />
      Logout
    </button>

  </div>
</aside>


    <div class="relative z-10 mx-auto flex w-full max-w-7xl flex-col gap-6">
      <section class="relative overflow-hidden rounded-[34px] border border-[var(--color-light)]/70 shadow-[0_24px_80px_rgba(40,0,0,0.12)]">
        <div class="absolute inset-0" :style="coverStyle"></div>
        <div class="absolute inset-0 bg-[var(--color-light)]/25 backdrop-blur-[2px]"></div>

        <div class="relative p-6 xl:p-8 lg:p-10">
          <div class="flex flex-col gap-6 lg:flex-row lg:items-end">
            <div class="flex items-end gap-5">
              <div
                class="flex h-28 w-28 items-center justify-center rounded-[38%_62%_58%_42%/46%_42%_58%_54%] border-2 border-[var(--color-light)]/90 shadow-[0_16px_30px_rgba(0,0,0,0.12)] text-5xl pb-4 font-black text-[var(--color-light)] bg-[var(--color-primary)]"
              >
               {{ initials }}
              </div>

              <div class="min-w-0">
                <p class="text-md font-bold uppercase tracking-[0.4em] text-[var(--color-dark)]/65">
                  Profile
                </p>

                <h1 class="mt-1 truncate text-4xl xl:text-5xl font-extrabold text-[var(--color-dark)]">
                  {{ currentUser?.username || 'User' }}
                </h1>

                <p class="mt-1 text-2xl text-[var(--color-dark)]/75">
                  {{ currentUser?.name || 'No name set' }}
                </p>

              </div>
            </div>

            <!-- Bagian yang diubah -->
            <div class="absolute bottom-6 right-6 lg:bottom-8 lg:right-10 flex flex-wrap gap-3">
            <button
                @click="openEditModal"
                class="inline-flex items-center gap-2 rounded-2xl bg-[var(--color-light)]/85 px-5 py-3 text-xl font-semibold text-[var(--color-dark)] shadow-xl transition hover:scale-[1.02]"
            >
                <PencilLine class="h-4 w-4" />
                Edit Profile
            </button>
            </div>
          </div>
        </div>
      </section>

      <section class="grid gap-4 xl:grid-cols-2 xl:grid-cols-4">
        <div
          v-for="stat in stats"
          :key="stat.label"
          class="rounded-[28px] border border-[var(--color-light)]/70 bg-[var(--color-light)]/90 p-5 shadow-[0_12px_40px_rgba(40,0,0,0.08)]"
        >
          <div class="flex items-center justify-between">
            <div>
              <p class="text-xl font-semibold uppercase tracking-[0.25em] text-[var(--color-dark)]/50">
                {{ stat.label }}
              </p>
              <p class="mt-2 text-3xl font-extrabold text-[var(--color-dark)]">
                {{ stat.value }}
              </p>
            </div>

            <div class="flex h-12 w-12 items-center justify-center rounded-2xl bg-[var(--color-cream)] text-[var(--color-primary)]">
              <component :is="stat.icon" class="h-5 w-5" />
            </div>
          </div>
        </div>
      </section>
      

      <section class="grid gap-6 xl:grid-cols-[0.85fr_1.45fr]">
      <div class="flex flex-col gap-6">
          <div class="rounded-[30px] border border-[var(--color-light)]/70 bg-[var(--color-light)]/92 p-6 shadow-[0_16px_50px_rgba(40,0,0,0.08)]">
            <div class="flex items-center gap-3">
              <div class="flex h-12 w-12 items-center justify-center rounded-2xl bg-[var(--color-cream)] text-[var(--color-primary)]">
                <Palette class="h-5 w-5" />
              </div>
              <div>
                <p class="text-xs font-bold uppercase tracking-[0.3em] text-[var(--color-dark)]/50">
                  Profile Preferences
                </p>
                <h2 class="text-2xl font-extrabold text-[var(--color-dark)]">
                  Cover pattern
                </h2>
              </div>
            </div>

            <p class="mt-4 text-xl leading-6 text-[var(--color-dark)]/70">
              Choose a soft pattern for the profile header. The selection is saved locally on this device.
            </p>

            <div class="mt-5 grid grid-cols-1 gap-3">
              <button
                v-for="theme in coverThemes"
                :key="theme.key"
                type="button"
                @click="setCover(theme.key)"
                class="group rounded-[22px] border p-3 text-left transition hover:shadow-xl"
                :class="selectedCover === theme.key ? 'border-[var(--color-primary)] ring-2 ring-[var(--color-primary)]/15' : 'border-[var(--color-soft)]/25'"
              >
                <div
                  class="h-20 rounded-[18px] border border-[var(--color-light)]/70"
                  :style="editCoverStyle(theme)"
                ></div>

                <div class="mt-3 flex items-center justify-between gap-3">
                  <div>
                    <p class="font-bold text-[var(--color-dark)]">{{ theme.label }}</p>
                    <p class="text-xs text-[var(--color-dark)]/60">Soft pattern cover</p>
                  </div>

                  <span
                    class="rounded-full px-3 py-1 text-xs font-bold"
                    :class="selectedCover === theme.key ? 'bg-[var(--color-primary)] text-[var(--color-light)]' : 'bg-[var(--color-cream)] text-[var(--color-dark)]'"
                  >
                    Selected
                  </span>
                </div>
              </button>
            </div>
          </div>

          
        </div>
        <div class="rounded-[30px] border border-[var(--color-light)]/70 bg-[var(--color-light)]/92 p-6 xl:p-7 shadow-[0_16px_50px_rgba(40,0,0,0.08)]">
          <div class="flex items-center justify-between gap-4">
            <div>
              <p class="text-xs font-bold uppercase tracking-[0.35em] text-[var(--color-dark)]/50">
                Dashboard
              </p>
              <h2 class="mt-1 text-3xl font-extrabold text-[var(--color-dark)]">
                Order List
              </h2>
            </div>

            <div class="rounded-full bg-[var(--color-cream)] px-4 py-2 text-xl font-semibold text-[var(--color-dark)]">
              {{ visibleOrders.length }} orders
            </div>
          </div>

          <div v-if="loading" class="py-16 text-center text-lg text-[var(--color-dark)]/70">
            Loading profile...
          </div>

          <div v-else-if="generalError" class="py-16 text-center text-lg text-red-500">
            {{ generalError }}
          </div>

          <div v-else-if="!visibleOrders.length" class="mt-8 rounded-[26px] border border-dashed border-[var(--color-soft)]/60 bg-[var(--color-cream)]/50 p-10 text-center">
            <div class="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-[var(--color-light)] shadow-xl">
              <ShoppingBag class="h-7 w-7 text-[var(--color-primary)]" />
            </div>
            <h3 class="mt-4 text-2xl font-bold text-[var(--color-dark)]">
              No orders yet
            </h3>
            <p class="mt-2 text-[var(--color-dark)]/70">
              Your order history will appear here after your first checkout.
            </p>
          </div>

          <div v-else class="mt-6 flex flex-col gap-5">
            <div
              v-for="order in visibleOrders.slice(0, 6)"
              :key="order.order_id"
              class="rounded-[24px] border border-[var(--color-soft)]/25 bg-[var(--color-light)]/80 p-4 transition hover:shadow-xl"
            >
              <button
                type="button"
                class="flex w-full items-center justify-between gap-4 text-left"
                @click="toggleOrder(order.order_id)"
              >
                <div class="min-w-0">
                  <div class="flex items-center gap-3">
                    <span class="inline-flex h-10 w-10 shrink-0 items-center justify-center rounded-2xl bg-[var(--color-light)] text-[var(--color-primary)] shadow-xl">
                      <ShoppingBag class="h-4 w-4" />
                    </span>
                    <div class="min-w-0">
                      <p class="truncate text-lg font-bold text-[var(--color-dark)]">
                        Order #{{ order.order_id }}
                      </p>
                      <p class="truncate text-xl text-[var(--color-dark)]/60">
                        {{ order.product?.name || 'Custom artwork' }} · {{ formatDate(order.order_date || order.created_at) }}
                      </p>
                    </div>
                  </div>
                </div>

                <div class="flex items-center gap-3">
                  <span
                    class="rounded-full border px-3 py-1 text-xs font-bold uppercase tracking-[0.2em]"
                    :class="statusClass(order.payment?.payment_status)"
                  >
                    {{ statusLabel(order.payment?.payment_status) }}
                  </span>

                  <span class="hidden xl:block text-lg font-bold text-[var(--color-dark)]">
                    {{ formatPrice(order.total_price || 0) }}
                  </span>

                  <ChevronDown
                    class="h-5 w-5 text-[var(--color-dark)]/70 transition-transform"
                    :class="{ 'rotate-180': expandedOrderId === order.order_id }"
                  />
                </div>
              </button>

              <div v-if="expandedOrderId === order.order_id" class="mt-4 grid gap-3 xl:grid-cols-2">
                <div class="rounded-2xl bg-[var(--color-light)] p-4">
                  <p class="text-xs font-bold uppercase tracking-[0.25em] text-[var(--color-dark)]/45">
                    Order info
                  </p>
                  <div class="mt-3 space-y-2 text-xl text-[var(--color-dark)]">
                    <p><span class="font-semibold">Email:</span> {{ order.customer_email || '-' }}</p>
                    <p><span class="font-semibold">Payment:</span> {{ order.payment?.payment_method || '-' }}</p>
                    <p><span class="font-semibold">Date:</span> {{ formatDate(order.order_date || order.created_at) }}</p>
                  </div>
                </div>

                <div class="rounded-2xl bg-[var(--color-light)] p-4">
                  <p class="text-xs font-bold uppercase tracking-[0.25em] text-[var(--color-dark)]/45">
                    Content summary
                  </p>

                  <div class="mt-3 space-y-2 text-xl text-[var(--color-dark)]">
                    <p><span class="font-semibold">Product:</span> {{ order.product?.name || '-' }}</p>
                    <p><span class="font-semibold">Characters:</span> {{ order.characters?.length || 0 }}</p>

                    <div v-if="order.characters?.length" class="mt-3 flex flex-wrap gap-2">
                      <span
                        v-for="char in order.characters.slice(0, 3)"
                        :key="char.character_id"
                        class="rounded-full bg-[var(--color-cream)] px-3 py-1 text-xs font-semibold text-[var(--color-dark)]"
                      >
                        {{ char.background?.name || 'No background' }}
                      </span>
                      <span
                        v-if="order.characters.length > 3"
                        class="rounded-full bg-[var(--color-cream)] px-3 py-1 text-xs font-semibold text-[var(--color-dark)]"
                      >
                        +{{ order.characters.length - 3 }} more
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        
      </section>
    </div>

    <!-- EDIT MODAL -->
    <div
      v-if="editing"
      class="fixed inset-0 z-[60] flex items-center justify-center bg-[rgba(40,0,0,0.45)] px-4 backdrop-blur-xl"
    >
      <div class="w-full max-w-xl overflow-hidden rounded-[28px] bg-[var(--color-light)] shadow-[0_30px_100px_rgba(0,0,0,0.28)]">
        <div class="border-b border-[var(--color-soft)]/20 px-6 py-5">
          <p class="text-md font-bold uppercase tracking-[0.35em] text-[var(--color-dark)]/45">
            Edit Profile
          </p>
          <h3 class="mt-1 text-3xl font-extrabold text-[var(--color-dark)]">
            Update your account
          </h3>
        </div>

        <form class="flex flex-col gap-4 px-6 py-6" @submit.prevent="saveProfile">
          <div class="flex flex-col gap-2">
            <label class="text-xl font-semibold text-[var(--color-dark)]">Name</label>
            <input v-model="formName" class="input-modern text-2xl py-1 px-4 pb-3" placeholder="Enter your name" />
          </div>

          <div class="flex flex-col gap-2">
            <label class="text-xl font-semibold text-[var(--color-dark)]">Username</label>
            <input v-model="formUsername" class="input-modern text-2xl py-1 px-4 pb-3" placeholder="Choose a username" />
            <p v-if="usernameError" class="text-xl text-red-500">
              {{ usernameError }}
            </p>
          </div>

          <div class="flex flex-col gap-2">
            <label class="text-xl font-semibold text-[var(--color-dark)]">Email</label>
            <input v-model="formEmail" type="email" class="input-modern text-2xl py-1 px-4 pb-3" placeholder="Enter your email" />
            <p v-if="emailError" class="text-xl text-red-500">
              {{ emailError }}
            </p>
          </div>

          <p v-if="generalError && !usernameError && !emailError" class="text-xl text-red-500">
            {{ generalError }}
          </p>

          <div class="mt-2 flex flex-wrap justify-end gap-3">
            <button
              type="button"
              @click="editing = false"
              class="rounded-xl border border-[var(--color-soft)]/30 px-5 py-3 text-xl font-semibold text-[var(--color-dark)] transition hover:bg-[var(--color-cream)]"
            >
              Cancel
            </button>

            <button
              type="submit"
              class="rounded-xl bg-[var(--color-primary)] px-5 py-3 text-xl font-semibold text-[var(--color-light)] transition hover:scale-[1.02] disabled:cursor-not-allowed disabled:opacity-60"
              :disabled="saving"
            >
              {{ saving ? 'Saving...' : 'Save Changes' }}
            </button>
          </div>
        </form>
      </div>
    </div>
    </div>
  </div>
</template>