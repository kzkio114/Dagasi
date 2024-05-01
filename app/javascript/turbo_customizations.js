document.addEventListener("turbo:before-stream-render", event => {
    if (event.target.getAttribute('id') === 'buttons') {
        event.target.innerHTML = ''; // フレームの内容をクリア
    }
});
