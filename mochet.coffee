# wire up stdin
process.stdin.resume()
process.stdin.setEncoding("utf8")

title     = if process.argv[2] then process.argv[2] else throw "Please specify a project title"
namespace = require("os").hostname()+"_"+require("os").platform()+"_"+require("os").release()

# an identifier is how we can uniquely identify a test suite run on a particular node
identifier =
    title: title
    namespace: namespace

zmq = require "zmq"

# get ready to pass on messages
push = zmq.socket "push"
push.connect "tcp://127.0.0.1:3456"

msg = ["identifier", identifier]
push.send JSON.stringify(msg)

process.stdin.on "data", (chunk) ->
    # proxy all stdin to console transparently (@todo make this optional)
    process.stdout.write chunk

    # deconstruct incoming packet, add our identifier and pass it on
    data = JSON.parse(chunk)
    data[1].identifier = identifier

    push.send JSON.stringify(data)

# ensure we terminate properly when stdin's done
process.stdin.on "end", ->
    process.exit()
