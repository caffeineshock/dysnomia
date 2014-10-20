class OnlineStatusManager
  status: {}

  constructor: (@channel, @uid, @cid, @path) ->
    PrivatePub.subscribe @channel, this.handleMessage
    setInterval (=>
      this.heartbeat()
      return
    ), 5000
    this.heartbeat()
    this.resynchronize()
    this.reply()

  heartbeat: =>
    for uid, data of @status
      for cid, data of @status[uid]
        passedTime = new Date() - data.lastReply
        if passedTime > 1000 * 2.5        
       	  this.markOffline uid, cid 
          this.resynchronize() 
    this.request()

  markOffline: (uid, cid) ->
    delete @status[uid][cid]
    delete @status[uid]

  request: ->
    this.sendMessage type: "request"

  reply: ->
    this.sendMessage type: "reply", path: @path

  resynchronize: ->
    $('.onlinestatus').each (j, span) =>
      uid = $(span).data('uid')
      if this.userOnline(uid)
        $(span).addClass("online")
      else
        $(span).removeClass("online")

      if this.userIsHere(uid)
      	$(span).addClass("ishere")
      else
        $(span).removeClass("ishere")

  handleMessage: (data) =>
    return if data.uid == @uid
    switch data.type
        when "request"
          this.handleRequest data
        when "reply"
          this.handleReply data

  handleRequest: (data) ->
     this.reply()

  handleReply: (data) ->
    if @status[data.uid] == undefined
      @status[data.uid] = {}
    if @status[data.uid][data.cid] == undefined
       @status[data.uid][data.cid] = {}
    @status[data.uid][data.cid]["lastReply"] = new Date()
    @status[data.uid][data.cid]["path"] = data.path
    this.resynchronize()

  sendMessage: (data) ->
    data.uid = @uid
    data.cid = @cid
    PrivatePub.publish @channel, data

  userOnline: (uid) ->
    @uid == uid or @status[uid] != undefined

  userIsHere: (uid) ->
    return false unless @status[uid] != undefined
    for cid, data of @status[uid]
      return true if data.path == @path
    false

$.turboInit ->
  new OnlineStatusManager(
  	window.onlinestatus_channel,
  	window.current_user,
  	window.connection_id,
  	window.location.pathname
  )