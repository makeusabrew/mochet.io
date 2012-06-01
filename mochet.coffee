# wire up stdin
process.stdin.resume()
process.stdin.setEncoding("utf8")

title = if process.argv[2] then process.argv[2] else throw "Please specify a project title"

zmq = require "zmq"

# get ready to pass on messages
push = zmq.socket "push"
push.connect "tcp://127.0.0.1:3456"

msg = ["namespace", title]
push.send JSON.stringify(msg)

process.stdin.on "data", (chunk) ->
    console.log chunk
    data = JSON.parse(chunk)
    data[1].namespace = title

    push.send JSON.stringify(data)
