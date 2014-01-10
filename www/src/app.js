var WebSocket = require('ws')
  , ws = new WebSocket('ws://localhost:8080/comms')

ws.onopen = function() {
  ws.send('ready')
}

ws.onmessage = function(data, flags) {
  console.log(data, flags)
}
