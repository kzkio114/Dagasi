import React from 'react';
import ReactDOM from 'react-dom';
import App from '../../src/components/App';

document.addEventListener('turbo:load', () => {
  const reactMount = document.getElementById('react-root');
  if (reactMount) {
    ReactDOM.render(<App />, reactMount);
  }
});

document.addEventListener('turbo:before-cache', () => {
  const reactMount = document.getElementById('react-root');
  if (reactMount) {
    ReactDOM.unmountComponentAtNode(reactMount);
  }
});
