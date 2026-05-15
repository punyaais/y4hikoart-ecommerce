export default {
    content: [
        "./index.html",
        "./src/**/*.{vue,js,ts,jsx,tsx}",
    ],
    theme: {
        extend: {},
    },
    plugins: [],
  theme: {
    extend: {
      colors: {
        primary: 'var(--color-primary)',
        secondary: 'var(--color-secondary)',
        dark: 'var(--color-dark)',
        light: 'var(--color-light)',
        soft: 'var(--color-soft)',
        cream: 'var(--color-cream)',
        main: 'var(--color-1)',
      },
      fontFamily: {
        main: ['var(--font-main)'],
      }
    }
  }
}