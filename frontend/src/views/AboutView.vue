<script setup lang="ts">
import { onMounted, onUnmounted, ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import ProductCard from '@/components/products/ProductCard.vue'
import axios from 'axios'
import {
  ChevronLeft,
  ShoppingCart,
  Star,
  ChevronRight,
  MessageCircleMore,
  ClipboardList,
  Brush,
  Palette
} from 'lucide-vue-next'

const router = useRouter()

const goShop = () => {
  router.push('/shop')
}

const goTerms = () => {
  router.push('/terms')
}

const goOrders = () => {
  router.push('/orders')
}

const goContact = () => {
  window.open('https://ig.me/m/y4hikoart', '_blank')
}

type SlideButton = {
  text: string
  action?: () => void
  variant?: 'primary' | 'secondary'
  icon?: any
}

type Slide = {
  title: string
  subtitle: string
  description: string
  leftDescription?: string
  rightDescription?: string
  bgImage: string
  figureImage: string
  leftBadge?: string

  figureWidth?: string
  figureScale?: string
  figureAlign?: 'left' | 'center' | 'right'
  figureOffsetY?: string
  figureOffsetX?: string

  buttons?: SlideButton[]
}

type ProductItem = {
  name: string
  price: string
  image: string
  tag: string
}

type TestimonialCard = {
  id: number
  name: string
  role: string
  text: string
  rating: number
}



const slides: Slide[] = [
  {
    title: 'About Me',
    description: 'I create commission artworks with a soft and playful look, made to match your favorite characters and stories.',
    bgImage: '/images/home/Rectangle 203.png',
    figureImage: '/images/home/frieren_20251018184112 2.png',
    leftBadge: 'Open for commissions',
    figureWidth: '720px',
    figureScale: '1',
    figureAlign: 'left',
    figureOffsetY: '1px',

     buttons: [
      {
        text: 'Chat Me',
        action: goContact,
        variant: 'secondary',
        icon: MessageCircleMore
      }
    ]
  },
  {
    title: 'Before Start Your Order',
    description:
      'Please check the commission terms before placing an order so everything stays smooth and clear.',
    bgImage: '/images/home/Rectangle 202 (2).png',
    figureImage: '/images/home/Hatsune miku ponytail_20251018173238 1.png',
    leftBadge: 'Terms & conditions',
    figureWidth: '530px',
    figureScale: '1',
    figureAlign: 'right',
    figureOffsetY: '1px',
    buttons: [
      {
        text: 'Terms & Conditions',
        action: goTerms,
        variant: 'primary'
      }
    ]
  },
  {
    leftDescription: `
    Can draw:
    • boys/girls
    • loli/shota
    • wearing hijab
    • chibi
    • fanart
    `,

    rightDescription: `
    Can’t draw:
    • mecha
    • realist
    • furry
    • nsfw
    • lgbtq+
    `,
    bgImage: '/images/home/Rectangle 272 (2).png',
    figureImage: '/images/home/kannakamui_20251018181950.png',
    leftBadge: 'For Your Information',
    figureWidth: '870px',
    figureScale: '1',
    figureAlign: 'right',
    figureOffsetY: '1px',
    figureOffsetX: '120px'
  },
  {
    title: 'Ready to Order Your Art?',
    description: 'Choose the style you like, prepare your reference, and send your idea to start the order.',
    bgImage: '/images/home/Rectangle 272.png',
    figureImage: '/images/home/violett_20251018181100.png',
    leftBadge: 'Go to shop',
    figureWidth: '500px',
    figureScale: '1',
    figureAlign: 'left',
    figureOffsetY: '1px',
    buttons: [
      {
        text: 'SHOP',
        action: goShop,
        variant: 'primary',
        icon: ShoppingCart
      }
    ]
  },
  {
    title: 'After You Order',
    description: 'Check your order status, sketch progress, and final result in the order list page.',
    bgImage: '/images/home/Rectangle 202 (1).png',
    figureImage: '/images/home/frieren_20251018184112 1.png',
    leftBadge: 'Order update',
    figureWidth: '700px',
    figureScale: '1',
    figureAlign: 'right',
    figureOffsetY: '1px',
    buttons: [
      {
        text: 'Order List',
        action: goOrders,
        variant: 'primary',
        icon: ClipboardList
      }
    ]
  }
]

const bestProducts = ref<any[]>([])
const fetchBestProducts = async () => {
  try {
    const res = await axios.get('http://127.0.0.1:8000/api/products/popular')

    bestProducts.value = res.data
  } catch (err) {
    console.error('ERROR POPULAR PRODUCTS:', err)
  }
}

const testimonials = ref<TestimonialCard[]>([])

const fetchTestimonials = async () => {
  try {
    const res = await axios.get(
      'http://127.0.0.1:8000/api/testimonials'
    )

    testimonials.value = (res.data.data || [])
      .slice(0, 10)
      .map((item: any) => ({
        id: item.id,

        name: item.show_username
          ? (item.user?.name || item.user?.username || 'Customer')
          : 'Anonymous',

        role: 'Verified Client',

        text: item.comment,
        rating: item.rating
      }))
  } catch (err) {
    console.error('ERROR FETCH TESTIMONIALS:', err)
  }
}

const testimonialTrack = computed(() => {
  return [...testimonials.value, ...testimonials.value]
})

const activeSlide = ref(0)
const slide = computed(() => slides[activeSlide.value])
const isFigureLeft = computed(() => slide.value.figureAlign === 'left')

let timer: number | undefined

const nextSlide = () => {
  activeSlide.value = (activeSlide.value + 1) % slides.length
}

const prevSlide = () => {
  activeSlide.value = (activeSlide.value - 1 + slides.length) % slides.length
}

const goToSlide = (index: number) => {
  activeSlide.value = index
}

const startAutoSlide = () => {
  if (timer) window.clearInterval(timer)
  timer = window.setInterval(nextSlide, 8000)
}

const nextSlideManual = () => {
  nextSlide()
  startAutoSlide()
}

const prevSlideManual = () => {
  prevSlide()
  startAutoSlide()
}

const goToSlideManual = (index: number) => {
  goToSlide(index)
  startAutoSlide()
}

onMounted(() => {
  startAutoSlide()
  fetchBestProducts()
  fetchTestimonials()
})

onUnmounted(() => {
  if (timer) window.clearInterval(timer)
})

const figureStyle = computed(() => {
  const s = slide.value

  const style: Record<string, string> = {
    width: s.figureWidth || '420px',
    bottom: '0px',
    top: 'auto',
    transformOrigin: 'bottom center',
    transform: `
      translateX(${s.figureOffsetX || '0px'})
      translateY(${s.figureOffsetY || '0px'})
      scale(${s.figureScale || 1})
    `
  }

  if (s.figureAlign === 'left') {
    style.left = '0'
  } else if (s.figureAlign === 'center') {
    style.left = '50%'
    style.transform = `
      translateX(calc(-50% + ${s.figureOffsetX || '0px'}))
      translateY(${s.figureOffsetY || '0px'})
      scale(${s.figureScale || 1})
    `
  } else {
    style.right = '0'
  }

  return style
})

const bgOverlayClass = computed(() => {
  return isFigureLeft.value
    ? 'bg-gradient-to-l from-white/40 via-white/25 to-transparent'
    : 'bg-gradient-to-r from-white/70 via-white/40 to-transparent'
})


const instagramUrl = 'https://www.instagram.com/y4hikoart/'
const goInstagram = () => {
  window.open(instagramUrl, '_blank')
}

const galleryItems = [
  { src: '/images/home/elaina.png', className: '' },
  { src: '/images/home/dtiys amopyy.png', className: '' },
  { src: '/images/home/violett.png', className: 'row-span-2' },
  { src: '/images/home/komis(1)_20250705092130.png', className: '' },

  { src: '/images/home/naraya art contest.png', className: 'row-span-2' },
  { src: '/images/home/komis(4)_20250713125914.png', className: '' },
  { src: '/images/home/wendydtiys.png', className: '' },
  { src: '/images/home/Beatrix M4.png', className: 'col-span-2' },
  { src: '/images/home/stiker.png', className: '' }
]
</script>

<template>
  <div class="min-h-screen home-shell flex flex-col items-center ">
    <!-- HERO CAROUSEL -->
    <section class="px-4 pt-40 md:pt-48 w-full flex justify-center">
      <div class="mx-auto max-w-[1400px] w-full">
        <div class="relative h-[600px] overflow-visible">

          <!-- BACKGROUND -->
          <div class="absolute inset-0 w-full h-full rounded-[36px] overflow-hidden bg-[var(--color-light)]">
            <img
              :src="slide.bgImage"
              class="absolute inset-0 w-full h-full object-cover object-center block scale-110"
            />
            <div class="absolute inset-0" :class="bgOverlayClass"></div>
          </div>

          <!-- CONTENT -->
          <div class="relative z-10 grid h-full items-center gap-8 px-10 md:px-16 lg:grid-cols-2 lg:px-24">
            <div
              class="max-w-[620px] flex flex-col gap-6 px-4 lg:px-8 items-start"
              :class="
                isFigureLeft
                  ? 'lg:col-start-2 lg:text-right lg:items-end lg:ml-auto lg:pr-12'
                  : 'lg:col-start-1 lg:text-left lg:items-start lg:pl-6'
              "
            >
              <div
                class="inline-flex  items-center gap-2 rounded-full bg-[var(--color-cream)]/20 px-4 py-2 text-md font-bold uppercase tracking-[0.35em] text-[var(--color-dark)] shadow-sm"
                :class="isFigureLeft ? 'lg:ml-auto' : ''"
              >
                {{ slide.leftBadge }}
              </div>

              <h1
                v-if="slide.title"
                class="whitespace-nowrap text-[clamp(3rem,5vw,5.8rem)] leading-none tracking-tight text-[var(--color-dark)] drop-shadow-sm"
              >
                {{ slide.title }}
              </h1>
              <!-- NORMAL DESCRIPTION -->
              <p
                v-if="slide.description"
                :class="[
                  'whitespace-pre-line text-2xl md:text-[1.7rem] leading-[1.7] text-[var(--color-dark)]/80',
                  isFigureLeft
                    ? 'w-full max-w-[42ch] ml-auto text-right'
                    : 'w-full max-w-[42ch] text-left'
                ]"
              >
                {{ slide.description }}
              </p>

              <!-- SPLIT DESCRIPTION -->
              <div
                v-if="slide.leftDescription || slide.rightDescription"
                class="grid grid-cols-2 gap-30"
              >
                <div>
                  <p class="whitespace-pre-line text-base md:text-4xl leading-10 text-[var(--color-dark)]/90">
                    {{ slide.leftDescription }}
                  </p>
                </div>

                <div>
                  <p class="whitespace-pre-line text-base md:text-4xl leading-10 text-[var(--color-dark)]/90">
                    {{ slide.rightDescription }}
                  </p>
                </div>
              </div>

              <div
                v-if="slide.buttons?.length"
                class="flex flex-wrap gap-5 pt-2"
                :class="isFigureLeft ? 'lg:justify-end' : ''"
              >
                <button
                  v-for="(button, index) in slide.buttons"
                  :key="index"
                  @click="button.action?.()"
                  class="
                    inline-flex
                    items-center
                    gap-3
                    rounded-2xl
                    bg-[var(--color-secondary)]
                    px-8
                    py-2
                    pb-4
                    text-lg
                    font-bold
                    text-[var(--color-dark)]
                    shadow-lg
                    transition-all
                    duration-300
                    hover:scale-[1.04]
                    hover:shadow-2xl
                    uppercase
                  "
                >
                  {{ button.text }}

                  <component
                    v-if="button.icon"
                    :is="button.icon"
                    class="h-5 w-5 pt-1"
                  />
                </button>
              </div>
            </div>
          </div>

          <!-- FIGURE -->
          <div class="absolute inset-0 z-20 pointer-events-none overflow-visible">
            <div
              :key="activeSlide"
              class="figure-reveal absolute inset-0 overflow-visible"
            >
              <img
                :src="slide.figureImage"
                class="absolute pointer-events-none select-none"
                :style="figureStyle"
              />
            </div>
          </div>

          <!-- CONTROLS -->
          <button @click="prevSlideManual" class="absolute left-4 top-1/2 z-20">
            <ChevronLeft class="h-8 w-8 text-[var(--color-dark)]" />
          </button>

          <button @click="nextSlideManual" class="absolute right-4 top-1/2 z-20">
            <ChevronRight class="h-8 w-8 text-[var(--color-dark)]" />
          </button>

          <div class="absolute bottom-5 left-1/2 z-20 flex -translate-x-1/2 gap-2">
            <button
              v-for="(_, index) in slides"
              :key="index"
              @click="goToSlideManual(index)"
              class="h-3 rounded-full transition-all duration-300"
              :class="activeSlide === index ? 'w-10 bg-[var(--color-primary)]' : 'w-3 bg-white/80'"
            />
          </div>
        </div>
      </div>
    </section>

    <!-- BEST PRODUCTS -->
    <section class="mx-auto max-w-7xl px-4 py-16 flex flex-col gap-10">
      <div class="text-center">
        <h2 class="text-5xl font-extrabold text-[var(--color-dark)] md:text-4xl">
          Featured Art Commissions
        </h2>
        <p class="mt-3 text-[var(--color-dark)]/70 text-2xl">
          A few of the most loved commission types, made to fit different needs and budgets.
        </p>
      </div>

      <div class="mt-10 grid gap-5 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 justify-items-center">
        <div class="w-full max-w-[250px]" v-for="product in bestProducts" :key="product.id">
          <ProductCard :product="product" />
        </div>
      </div>
      <div class="flex justify-center text-xl">
        <button
          @click="goShop"
          class="text-2xl uppercase inline-flex items-center gap-2 rounded-xl bg-[var(--color-secondary)] px-10 py-3 pb-4 font-bold text-[var(--color-dark)] shadow transition hover:scale-[1.02]"
        >
          Go Shop
          <ShoppingCart class="h-5 w-5 pt-1" />
        </button>
      </div>
    </section>

    <!-- GALLERY -->
    <section class="mx-auto max-w-7xl px-4 py-20">
      <div class="relative">

        <!-- FLOATING CONTENT -->
        <div
          class="
            absolute
            left-1/2
            top-1/2
            z-10
            w-full
            max-w-[550px]
            -translate-x-1/2
            -translate-y-1/2

            rounded-[32px]
            border
            border-white/20
            bg-[var(--color-primary)]/10
            px-12
            py-10
            overflow-hidden
            backdrop-blur-xs
            backdrop-saturate-150
            shadow-[0_18px_60px_rgba(0,0,0,0.22)]
          "
        >
        <!-- GLASS OVERLAY -->
        <div
          class="
            pointer-events-none
            absolute
            inset-0
            bg-gradient-to-br
            from-white/20
            via-white/5
            to-transparent
          "
        ></div>

        <!-- TOP LIGHT -->
        <div
          class="
            pointer-events-none
            absolute
            top-0
            left-0
            h-[1px]
            w-full
            bg-white/30
          "
        ></div>

        <!-- CONTENT -->
        <div class="relative z-10">

          <!-- SMALL LABEL -->
          <p
            class="
              mb-4
              text-xl
              text-center
              font-bold
              uppercase
              tracking-[0.35em]
              text-white/80
            "
          >
            Featured Artwork Collection
          </p>

          <!-- TITLE -->
          <h2
            class="
              mb-5
              text-center
              text-5xl
              md:text-7xl
              font-extrabold
              leading-none
              tracking-tight
              text-[var(--color-primary)]
              drop-shadow-[0_5px_18px_rgba(0,0,0,0.35)]
            "
            style="
              -webkit-text-stroke: 0.5px rgb(255, 255, 255);
            "
          >
            My Gallery
          </h2>

          <!-- DESCRIPTION -->
          <p
            class="
              mx-auto
              mt-7
              max-w-[560px]
              text-2xl
              text-center
              leading-[2.3]
              tracking-[0.08em]
              text-white/90
            "
          >
            Explore my artworks and creative projects
          </p>

          <!-- BUTTON -->
          <div class="mt-8 flex justify-center">
            <button
              @click="goInstagram"
              class="
                inline-flex
                items-center
                gap-2
                rounded-2xl
                bg-[var(--color-secondary)]
                px-8
                py-2
                pb-4
                uppercase
                text-2xl
                font-bold
                text-[var(--color-dark)]
                shadow-[0_12px_34px_rgba(0,0,0,0.24)]
                transition-all
                duration-300
                hover:scale-[1.05]
                hover:shadow-[0_18px_44px_rgba(0,0,0,0.3)]
              "
            >
              Visit
              <Palette class="h-7 w-7 pt-2" />
            </button>
          </div>

          </div>
        </div>

        <!-- GRID -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 auto-rows-[220px]">

          <div
            v-for="(item, index) in galleryItems"
            :key="index"
            :class="[
              'overflow-hidden rounded-[24px] shadow-lg',
              item.className
            ]"
          >
            <img
              :src="item.src"
              alt="gallery"
              class="
                h-full
                w-full
                object-cover
                transition
                duration-500
                hover:scale-105
              "
            />
          </div>

        </div>
      </div>
    </section>

    <!-- TESTIMONIALS -->
    <section
      class="
        relative
        w-full
        overflow-hidden
        py-7
      "
    >
      <!-- decorative blur -->
      <div
        class="
          absolute
          left-[-120px]
          top-20
          h-[300px]
          w-[300px]
          rounded-full
          bg-pink-200/30
          blur-3xl
        "
      ></div>

      <div
        class="
          absolute
          right-[-120px]
          bottom-10
          h-[300px]
          w-[300px]
          rounded-full
          bg-purple-200/20
          blur-3xl
        "
      ></div>

      <div class="relative mx-auto max-w-[1800px]">

        <!-- HEADER -->
        <div class="text-center">
            <h2 class="text-5xl font-extrabold text-[var(--color-dark)] md:text-4xl">
              Customer Experiences
            </h2>
            <p class="mt-3 text-[var(--color-dark)]/70 text-2xl">
              Reviews and experiences from clients who ordered commission artworks
            </p>
          </div>

        <!-- SLIDER -->
        <div class="testimonial-track flex items-stretch gap-8 px-6">

          <!-- TRACK -->
          <div class="testimonial-track flex items-stretch gap-8 px-6 py-10">

            <article
              v-for="(item, index) in testimonialTrack"
              :key="`${item.id}-${index}`"
              class="
                relative
                flex
                min-h-[90px]
                min-w-[400px]
                max-w-[200px]
                rounded-[30px]
                flex-col
                rounded-[38px]
                border
                border-white/70
                bg-white/80
                p-8
                backdrop-blur-xl
                shadow-[0_20px_60px_rgba(0,0,0,0.08)]
                transition-all
                duration-500
                hover:-translate-y-2
                hover:shadow-[0_25px_80px_rgba(0,0,0,0.14)]
              "
            >

              <!-- quote -->
              <div
                class="
                  absolute
                  right-6
                  top-4
                  text-8xl
                  font-black
                  leading-none
                  text-[var(--color-primary)]/10
                "
              >
                ”
              </div>

              <!-- USER -->
              <div class="flex items-center gap-4">

                <!-- INITIAL -->
                <div
                  class="
                    flex
                    h-12
                    w-12
                    shrink-0
                    items-center
                    justify-center
                    rounded-full
                    bg-[var(--color-primary)]
                    text-2xl
                    font-black
                    text-white
                    shadow-lg
                  "
                >
                  {{
                    item.name
                      ?.split(' ')
                      .map((word: string) => word[0])
                      .join('')
                      .slice(0, 2)
                      .toUpperCase()
                  }}
                </div>

                <div class="min-w-0">
                  <h3
                    class="
                      truncate
                      text-2xl
                      font-bold
                      text-[var(--color-dark)]
                    "
                  >
                    {{ item.name }}
                  </h3>

                  <p
                    class="
                      mt-1
                      text-sm
                      font-bold
                      uppercase
                      tracking-[0.3em]
                      text-[var(--color-primary)]/70
                    "
                  >
                    {{ item.role }}
                  </p>
                </div>
              </div>

              <!-- STARS -->
              <div class="mt-6 flex gap-1">
                <Star
                  v-for="n in 5"
                  :key="n"
                  class="h-5 w-5"
                  :class="
                    n <= item.rating
                      ? 'fill-[var(--color-secondary)] text-[var(--color-secondary)]'
                      : 'text-[var(--color-soft)]'
                  "
                />
              </div>

              <!-- TEXT -->
              <p
                class="
                  mt-6
                  flex-1
                  text-2xl
                  leading-[2]
                  text-[var(--color-dark)]/75
                "
              >
                “{{ item.text }}”
              </p>

              <!-- bottom line -->
              <div
                class="
                  mt-8
                  h-[2px]
                  w-full
                  rounded-full
                  bg-gradient-to-r
                  from-[var(--color-primary)]/20
                  to-transparent
                "
              ></div>

            </article>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

