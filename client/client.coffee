_socket    = null
_connected = false
_wrapper   = $("[data-wrapper]")
_current   = {}

Client =
    connect: ->
        return false if not io?
        
        _socket = io.connect()

        _socket.on "connect", ->
            _connected = true

        _socket.on "namespace", (title) ->
            content = _wrapper.find("[data-title='#{title}']")

            if content.length
                content.empty()
            else
                content = $("<div></div>").attr("data-title", title)
                _wrapper.append content

            _current[title] = 0

            h2 = $("<h2></h2>")
            .html(title)
            .append(" (<span data-current>0</span> / <span data-total>?</span>)")

            tests = $("<ul></ul>").attr("data-tests", "")

            content
            .append(h2)
            .append(tests)

        _socket.on "start", (data) ->
            console.log data
            content = _wrapper.find("[data-title='#{data.namespace}']")
            return if content.length is 0

            content.find("[data-total]").html(data.total)
            

        _socket.on "pass", (data) ->
            Client.addTest "pass", data

        _socket.on "fail", (data) ->
            Client.addTest "fail", data

    addTest: (type, data) ->
        content = _wrapper.find("[data-title='#{data.namespace}']")

        return if content.length is 0

        _current[data.namespace] += 1

        content.find("[data-current]").html(_current[data.namespace]);
        
        symbol = if type is "pass" then "✔" else "✘"

        li = $("<li>#{symbol} #{data.fullTitle}</li>")
        content.find("ul").append(li)
        


module.exports = Client
