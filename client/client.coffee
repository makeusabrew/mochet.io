_socket    = null
_connected = false

PageController = require "./controllers/page"

Client =
    connect: ->
        return false if not io?
        
        _socket = io.connect()

        _socket.on "connect", ->
            _connected = true

        _socket.on "message", (packet) ->
            try
                messages = JSON.parse(packet)
                
                # messages can be chunked together to save bandwidth, so we always expect each packet
                # to be an array of *at least* one message, so we have to split it here and act accordingly

                for message in messages
                    method = message[0]
                    data   = message[1]

                    switch method
                        when "identifier" then PageController.createSuite data
                        when "start"      then PageController.startSuite data
                        when "pass"       then PageController.addTest "pass", data
                        when "fail"       then PageController.addTest "fail", data
                        when "end"        then PageController.endSuite data
                        else console.log "ignoring method #{method}"
            catch e
                console.error e

    bindHandlers: ->
        $(document).on "click", ".suite-label", (e) ->
            e.preventDefault()
            $(".suite").hide()
            
            identifier = $(this).parent().attr("data-identifier")
            $(".suite[data-identifier='#{identifier}']").show()

module.exports = Client
