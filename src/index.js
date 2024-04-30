import http from 'http';
import React from 'react';
import ReactDOMServer from 'react-dom/server';
import App from './components/App';

const server = http.createServer((req, res) => {
  const html = ReactDOMServer.renderToString(<App />);
  res.write('<!DOCTYPE html><html><head><title>My Page</title></head><body>');
  res.write(html);
  res.write('</body></html>');
  res.end();
});

server.listen(3000);