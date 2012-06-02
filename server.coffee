#!/usr/local/bin/coffee
express = require "express"
app     = express.createServer()
io      = require("socket.io").listen(app)
zmq     = require "zmq"

# who's there?
app.listen "8765"

# config
app.configure ->
    app.use express.static("#{__dirname}/public")
    app.set "view engine", "jade"

    app.set "view options", {layout: false}
    app.set "views", "./server/views"

    bundle = require("browserify")({mount:"/boot.js", entry:"./client/boot.coffee"})
    app.use bundle

#io.configure ->
#    io.set "transports", ["websocket"]

# load routes
require("./server/routes/url").load app

# wire up sockets
io.sockets.on "connection", (socket) ->
    ###
    ## client boot stuff
    ###
    socket.emit "hello"


# listen out for inbound queue messages
pull = zmq.socket "pull"
pull.bind "tcp://127.0.0.1:3456", ->

    pull.on "message", (data) ->
        # we simply proxy messages through to the client
        # each packet might be multiple (sometimes MANY) actual
        # messages, so if we split them out here we'll swamp clients
        io.sockets.emit "message", data.toString("utf-8")
