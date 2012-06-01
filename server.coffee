express = require "express"
app     = express.createServer()
io      = require("socket.io").listen(app)
app.listen "8765"

# config
app.configure ->
    app.use express.static("#{__dirname}/public")
    app.set "view engine", "jade"

    app.set "view options", {layout: false}
    app.set "views", "./server/views"

    bundle = require("browserify")({mount:"/boot.js", entry:"./client.coffee"})
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
    superSocket = new SuperSocket socket

    superSocket.changeState "welcome"

    ###
    ## one off static controller 
