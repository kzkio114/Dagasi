const esbuild = require('esbuild');
const sassPlugin = require('esbuild-plugin-sass');

esbuild.build({
  entryPoints: ['./app/src/index.jsx'],
  bundle: true,
  outfile: './app/assets/builds/bundle.js',
  plugins: [sassPlugin()],
  define: {
    'process.env.NODE_ENV': '"development"',
  },
  loader: {
    '.js': 'jsx',
    '.jsx': 'jsx',
    '.ts': 'ts',
    '.tsx': 'tsx'
  },
  sourcemap: true,  // ソースマップを生成
  watch: process.argv.includes('--watch') && {
    onRebuild(error, result) {
      if (error) {
        console.error('再ビルド中にエラーが発生しました:', error);
      } else {
        console.log('再ビルドが成功しました:', result);
      }
    }
  }
}).catch(error => {
  console.error('ビルド失敗:', error);
});

