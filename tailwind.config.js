module.exports = {
  content: [
    "./app/views/**/*.{html,erb,haml}",
    "./app/javascript/**/*.{js,jsx,ts,tsx,vue}",
  ],
  theme: {
    extend: {
      fontFamily: {
        'monomaniac': ['"Monomaniac One"', 'monospace'] ,
        'kosugi-maru': ['Kosugi Maru', 'sans-serif'], // monospaceをフォールバックフォントとして追加
      },
      colors: {
        'nostalgic-turquoise': '#00a497',
        'nostalgic-green': '#669977',// 懐かしい感じの緑色 colorsも追記
        'vintage-blue': '#4a5d70', // 深いが暗めの青色
        'cream': '#f5f5dc',
        'soft-black': '#323232',
        'vintage-red': '#cb4154',
        'dark-vintage-red': '#b4001e'
      }
    },
  },
  plugins: [
    require('daisyui'), // DaisyUIプラグインを追加
  ],
}