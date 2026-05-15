<script setup lang="ts">
import { ref, watch, nextTick } from 'vue'
import axios from 'axios'
import { useRouter, useRoute } from 'vue-router'
import { Eye, EyeOff } from 'lucide-vue-next'

const router = useRouter()
const route = useRoute()

const isLogin = ref(true)

if (route.query.mode === 'login') {
  isLogin.value = true
} else if (route.query.mode === 'register') {
  isLogin.value = false
}

const loading = ref(false)

const loginUsername = ref('')
const loginPassword = ref('')

const registerUsername = ref('')
const registerPassword = ref('')
const confirmPassword = ref('')
const name = ref('')
const email = ref('')

const showLoginPassword = ref(false)
const showRegisterPassword = ref(false)
const showConfirmPassword = ref(false)

const loginScrollRef = ref<HTMLElement | null>(null)
const registerScrollRef = ref<HTMLElement | null>(null)


const handleLogin = async () => {
  loading.value = true
  try {
    const res = await axios.post('/login', {
      username: loginUsername.value,
      password: loginPassword.value,
    })

    localStorage.setItem('token', res.data.token)
    localStorage.setItem('user', JSON.stringify(res.data.user))
    router.push('/')
  } catch (err: any) {
    alert(err?.response?.data?.message || 'Login gagal')
  } finally {
    loading.value = false
  }
}

const handleRegister = async () => {
  if (registerPassword.value !== confirmPassword.value) {
    alert('Password tidak sama')
    return
  }

  loading.value = true
  try {
    await axios.post('/register', {
      username: registerUsername.value,
      name: name.value,
      email: email.value,
      password: registerPassword.value,
      password_confirmation: confirmPassword.value,
    })

    alert('Register berhasil!')
    isLogin.value = true

    loginUsername.value = registerUsername.value
    loginPassword.value = ''

    registerUsername.value = ''
    registerPassword.value = ''
    confirmPassword.value = ''
    name.value = ''
    email.value = ''

    showRegisterPassword.value = false
    showConfirmPassword.value = false
  } catch (err: any) {
    alert(err?.response?.data?.message || 'Register gagal')
  } finally {
    loading.value = false
  }
}
watch(isLogin, async () => {
  await nextTick()
  loginScrollRef.value?.scrollTo({ top: 0, behavior: 'auto' })
  registerScrollRef.value?.scrollTo({ top: 0, behavior: 'auto' })
})
watch(() => route.query.mode, (mode) => {
  if (mode === 'login') isLogin.value = true
  if (mode === 'register') isLogin.value = false
})
</script>

<template>
  <div class="auth-shell min-h-screen flex items-center justify-center px-4 py-10">
  
    <div
      class="relative w-full max-w-[900px] h-[560px] rounded-[36px]
             overflow-hidden shadow-[0_28px_80px_rgba(0,0,0,0.22)]
             bg-[var(--color-light)] backdrop-blur-xl"
    >
      <div class="relative z-10 grid h-full lg:grid-cols-2 gap-6 p-4">
        <!-- LEFT SLOT -->
        <div class="relative min-h-[340px] lg:min-h-full overflow-hidden">
          <form
            v-if="!isLogin"
            @submit.prevent="handleRegister"
            class="h-full flex items-start justify-center px-6 md:px-10 py-8"
          >
            <div 
              ref="registerScrollRef"
              class="w-full max-w-[420px] max-h-full overflow-y-auto pr-5"
            >
              <div class="pl-2 pr-2 flex flex-col gap-5 py-2">
              <div class="text-center mb-2 md:mb-4">
                <h2 class="text-4xl md:text-4xl font-bold text-[var(--color-dark)]">
                  Create Account
                </h2>
              </div>

              <div class="flex flex-col gap-2">
                <label class="text-2xl font-medium text-[var(--color-dark)]">
                  Name
                </label>
                <input
                  v-model="name"
                  placeholder="Enter your name"
                  class="input-modern text-2xl py-1 px-4 pb-3"
                />
              </div>

              <div class="flex flex-col gap-2">
                <label class="text-2xl font-medium text-[var(--color-dark)]">
                  Username
                </label>
                <input
                  v-model="registerUsername"
                  placeholder="Choose a username"
                  class="input-modern text-2xl py-1 px-4 pb-3"
                />
              </div>

              <div class="flex flex-col gap-2">
                <label class="text-2xl font-medium text-[var(--color-dark)]">
                  Email
                </label>
                <input
                  v-model="email"
                  type="email"
                  placeholder="Enter your email"
                  class="input-modern text-2xl py-1 px-4 pb-3"
                />
              </div>

              <div class="flex flex-col gap-2">
                <label class="text-2xl font-medium text-[var(--color-dark)]">
                  Password
                </label>
                <div class="relative">
                  <input
                    v-model="registerPassword"
                    :type="showRegisterPassword ? 'text' : 'password'"
                    placeholder="Create a password"
                    class="input-modern text-2xl py-1 px-4 pb-3 pr-11"
                  />
                  <button
                    type="button"
                    @click="showRegisterPassword = !showRegisterPassword"
                    class="absolute right-3 top-1/2 -translate-y-1/2 text-[var(--color-dark)]/70 hover:text-[var(--color-primary)] transition"
                  >
                    <Eye v-if="!showRegisterPassword" class="w-5 h-5" />
                    <EyeOff v-else class="w-5 h-5" />
                  </button>
                </div>
              </div>

              <div class="flex flex-col gap-2">
                <label class="text-2xl font-medium text-[var(--color-dark)]">
                  Confirm Password
                </label>
                <div class="relative">
                  <input
                    v-model="confirmPassword"
                    :type="showConfirmPassword ? 'text' : 'password'"
                    placeholder="Retype your password"
                    class="input-modern text-2xl py-1 px-4 pb-3 pr-11"
                  />
                  <button
                    type="button"
                    @click="showConfirmPassword = !showConfirmPassword"
                    class="absolute right-3 top-1/2 -translate-y-1/2 text-[var(--color-dark)]/70 hover:text-[var(--color-primary)] transition"
                  >
                    <Eye v-if="!showConfirmPassword" class="w-5 h-5" />
                    <EyeOff v-else class="w-5 h-5" />
                  </button>
                </div>
              </div>

              <button type="submit" class="btn-main mt-2 text-2xl py-1 px-4 pb-3">
                {{ loading ? 'Loading...' : 'Sign Up' }}
              </button>

              <p class="text-center text-xl text-[var(--color-dark)]/80 mt-1">
                Already have an account yet?
                <button
                  type="button"
                  @click="isLogin = true"
                  class="font-semibold text-[var(--color-primary)] hover:underline"
                >
                  Sign In
                </button>
              </p>
            </div>
            </div>
          </form>
        </div>

        <!-- RIGHT SLOT -->
        <div class="relative min-h-[340px] lg:min-h-full overflow-hidden">
          <form
            v-if="isLogin"
            @submit.prevent="handleLogin"
            class="h-full flex items-center justify-center px-6 md:px-10 py-8"
          >
            <div 
            ref="loginScrollRef"
            class="w-full max-w-[420px] flex flex-col justify-center gap-5">
              <div class="text-center mb-2 md:mb-4">
                <h2 class="text-3xl md:text-4xl font-bold text-[var(--color-dark)]">
                  Sign In
                </h2>
              </div>

              <div class="flex flex-col gap-2">
                <label class="text-2xl font-medium text-[var(--color-dark)]">
                  Username
                </label>
                <input
                  v-model="loginUsername"
                  placeholder="Type your username"
                  class="input-modern text-2xl py-1 px-4 pb-3"
                />
              </div>

              <div class="flex flex-col gap-2">
                <label class="text-2xl font-medium text-[var(--color-dark)]">
                  Password
                </label>
                <div class="relative">
                  <input
                    v-model="loginPassword"
                    :type="showLoginPassword ? 'text' : 'password'"
                    placeholder="Type your password"
                    class="input-modern text-2xl py-1 px-4 pb-3 pr-11"
                  />
                  <button
                    type="button"
                    @click="showLoginPassword = !showLoginPassword"
                    class="absolute right-3 top-1/2 -translate-y-1/2 text-[var(--color-dark)]/70 hover:text-[var(--color-primary)] transition"
                  >
                    <Eye v-if="!showLoginPassword" class="w-5 h-5" />
                    <EyeOff v-else class="w-5 h-5" />
                  </button>
                </div>
              </div>

              <button type="submit" class="btn-main mt-2 text-2xl py-1 px-4 pb-3">
                {{ loading ? 'Loading...' : 'Sign In' }}
              </button>

              <p class="text-center text-xl text-[var(--color-dark)]/80 mt-1">
                Don't have an account yet?
                <button
                  type="button"
                  @click="isLogin = false"
                  class="font-semibold text-[var(--color-primary)] hover:underline"
                >
                  Sign Up
                </button>
              </p>
            </div>
          </form>
        </div>
      </div>

      <!-- SLIDING PINK PANEL -->
      <div
        class="absolute top-4 left-4 h-[calc(100%-2rem)] w-[calc(50%-1rem)]
              bg-[var(--color-primary)] text-[var(--color-light)]
              flex items-center justify-center px-8 z-20
              transition-transform duration-700 ease-in-out
              shadow-[0_12px_24px_rgba(40,0,0,0.18)]
              rounded-l-[42px] rounded-r-[42px]"
        :class="isLogin ? 'translate-x-0' : 'translate-x-full'"
        style="border: 1px solid rgba(245, 239, 232, 0.35);"
      >
        <div class="flex flex-col items-center text-center gap-5 max-w-sm px-6">
          
          <p class="absolute top-5 text-2xl tracking-widest uppercase ">
            y4hikoart
          </p>

          <h1 class="text-4xl md:text-5xl font-extrabold leading-tight">
            {{ isLogin ? 'Welcome Back' : 'Join Us Today' }}
          </h1>

          <p class="text-2xl opacity-90 max-w-sm leading-[1.6]">
            {{
              isLogin
                ? 'Access your account and continue exploring your creative journey with us'
                : 'Create your account and start building something amazing with us'
            }}
          </p>

          <button
            type="button"
            @click="isLogin = !isLogin"
            class="mt-2 absolute bottom-5 border border-[var(--color-light)] px-6 pb-2 rounded-lg text-xl
                  hover:bg-[var(--color-light)] hover:text-[var(--color-primary)]
                  transition-all duration-300"
          >
            {{ isLogin ? 'Create Account' : 'Back to Login' }}
          </button>

        </div>
      </div>
    </div>
  </div>
</template>