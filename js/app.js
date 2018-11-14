var {Elm} = require('./elm.js');

var flags

try {
  flags = JSON.parse(localStorage.getItem('cache') || '0')
} catch (e) {
  flags = 0
}

var app_node = document.querySelector('#app');
var app = Elm.Main.init({
  node: app_node,
  flags: flags
});

app.ports.cache.subscribe(function (data) {
  localStorage.setItem('cache', JSON.stringify(data))
})
