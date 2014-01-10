var WebSocket = require('ws')
  , ws = new WebSocket('ws://localhost:8080/comms')

ws.on('open', function() {
  ws.send('ready')
})

ws.on('message', function(data, flags) {
  console.log(data, flags)
})
