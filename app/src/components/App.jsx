import React from 'react';
import ReactDOM from 'react-dom';
import './App.css';  // スタイルシートのインポート
import Header from './components/Header';  // ヘッダーコンポーネントのインポート
import MainContent from './components/MainContent';  // メインコンテンツコンポーネントのインポート
import Footer from './components/Footer';  // フッターコンポーネントのインポート

function App() {
  return (
    <div className="App">
      <Header />
      <MainContent />
      <Footer />
    </div>
  );
}

export default App;