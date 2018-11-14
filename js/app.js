var {Elm} = require('./elm.js');

var app_node = document.querySelector('#app');
var app = Elm.Main.init({
  node: app_node
});

app.ports.sendMessage.subscribe(function (data) {
  app.ports.receiveMessage.send(data.split('').reverse().join(''))
})
