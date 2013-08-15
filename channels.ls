user-profile =
  friend: 2
  chat: 1

channels =
  init: (io)->  
    (socket) <-! io.sockets.on 'connection'
    console.log "connected"
    socket.emit 'ask-location', {web-url: null, world-position: null}

    (data) <-! socket.on 'answer-location'
    console.log data
    chat = io.of('/chats/' + user-profile.chat)
    friend = io.of('/friends/' + user-profile.friend)

    chat.on 'connection', (socket)!->
      console.log 'chat connected'
      socket.emit 'a message', {everyone: 'in', '/chat': 'will get'}

    friend.on 'connection', (socket)!->
      console.log 'friend connected'
      socket.emit 'item', {firends: 'item'}

    socket.emit 'channels-ready', {channels: ['chat', 'friend']}

module.exports <<< channels
