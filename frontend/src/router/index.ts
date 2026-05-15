import { createRouter, createWebHistory } from 'vue-router'
import AboutView from '../views/AboutView.vue'
import ProductView from '../views/ProductView.vue'
import ReceiptView from '../views/ReceiptView.vue'
import OrderView from '../views/OrderView.vue'
import OrderProgressView from '../views/OrderProgressView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: AboutView,
    },
    {
      path: '/shop',
      name: 'shop',
      component: ProductView,
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('../views/AboutView.vue'),
    },
    {
      path: '/receipt',
      name: 'Receipt',
      component: ReceiptView,
    },
    {
      path: '/orders',
      name: 'orders',
      component: OrderView,
      meta: { requiresAuth: true }
    },
    {
      path: '/orders-progress',
      name: 'OrderProgress',
      component: OrderProgressView,
      meta: { requiresAuth: true }
    },
    {
      path: '/products/:id',
      name: 'ProductDetail',
      component: () => import('@/views/ProductDetailView.vue')
    },
    {
      path: '/cart',
      name: 'Cart',
      component: () => import('@/views/CartView.vue')
    },
    {
      path: '/checkout',
      name: 'Checkout',
      component: () => import('@/views/CheckoutView.vue'),
      meta: { requiresAuth: true }
    },

    {
      path: '/auth',
      name: 'Auth',
      component: () => import('@/views/AuthView.vue')
    },
    {
      path: '/profile',
      name: 'Profile',
      component: () => import('@/views/ProfileView.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/terms',
      name: 'Terms',
      component: () => import('@/views/TermsView.vue')
    },
  ],
})
/* =========================
   🔥 TAMBAHKAN DI SINI
========================= */
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')

  if (to.meta.requiresAuth && !token) {
    next('/auth?mode=login')
  } else {
    next()
  }
})

export default router