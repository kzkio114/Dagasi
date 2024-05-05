module.exports = {
  content: [
    "./app/views/**/*.{html,erb,haml}",
    "./app/javascript/**/*.{js,jsx,ts,tsx,vue}",
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('daisyui'),
  ],
}
