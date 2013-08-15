(function(){
  var userProfile, channels;
  userProfile = {
    friend: 2,
    chat: 1
  };
  channels = {
    init: function(io){
      return io.sockets.on('connection', function(socket){
        console.log("connected");
        socket.emit('ask-location', {
          webUrl: null,
          worldPosition: null
        });
        socket.on('answer-location', function(data){
          var chat, friend;
          socket.emit('channels-ready', {
            channels: ['chat', 'friend']
          });
          console.log(data);
          chat = io.of('/chats/' + userProfile.chat);
          friend = io.of('/friends/' + userProfile.friend);
          chat.on('connection', function(socket){
            console.log('chat connected');
            return socket.emit('a message', {
              everyone: 'in',
              '/chat': 'will get'
            });
          });
          friend.on('connection', function(socket){
            console.log('friend connected');
            return socket.emit('item', {
              firends: 'item'
            });
          });
        });
      });
    }
  };
  import$(module.exports, channels);
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
