import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
// import App from './App01.vue'
import { createPinia } from 'pinia'
import router from './router'
import axios from 'axios'

axios.defaults.baseURL = 'http://127.0.0.1:8000/api'

axios.interceptors.request.use(config => {
  const token = localStorage.getItem('token')

  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }

  return config
})

const pinia = createPinia()
const app = createApp(App)

app.use(pinia)
app.use(router)   // ← INI yang kurang, makanya router-view tidak render apapun
app.use(createPinia())

app.mount('#app')