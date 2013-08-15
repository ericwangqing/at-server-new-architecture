console.log 'get it'

BASE_URL = 'http://localhost'

user-profile =
  friend: 2
  chat: 1

socket = io.connect BASE_URL
do
  (data) <-! socket.on 'ask-location' 
  console.log data
  socket.emit 'answer-location', {web-url: window.href, world-position: null}
do  
  (data) <-! socket.on 'channels-ready'
  console.log data
  chat = io.connect BASE_URL + '/chats/' + user-profile.chat
  friend = io.connect BASE_URL + '/friends/' + user-profile.friend
  do
    (data) <-! chat.on 'connect'
    console.log data
    chat.emit 'hi!'
  do
    (data) <-! friend.on 'connect'
    console.log data
    friend.emit 'dear~'


