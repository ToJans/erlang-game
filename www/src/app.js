var WebSocket = require('ws')
  , ws = new WebSocket('ws://localhost:8080/comms')


var container = document.getElementById('container')

ws.onopen = function() {
  ws.send('ready')
}

ws.onmessage = function(msg, flags) {
  container.innerHTML += "<p>" + msg.data + "</p>"
}
