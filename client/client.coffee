_socket    = null
_connected = false
_wrapper   = $("[data-wrapper]")
_current   = {}

PageController = require "./controllers/page"

Client =
    connect: ->
        return false if not io?
        
        _socket = io.connect()

        _socket.on "connect", ->
            _connected = true

        _socket.on "namespace", (data) ->
            PageController.createNamespace data

        _socket.on "start", (data) ->
            PageController.startSuite data

        _socket.on "pass", (data) ->
            PageController.addTest "pass", data

        _socket.on "fail", (data) ->
            PageController.addTest "fail", data

        _socket.on "end", (data) ->
            PageController.endSuite data

module.exports = Client
