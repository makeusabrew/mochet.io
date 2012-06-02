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

msg = [["identifier", identifier]]
push.send JSON.stringify(msg)

require "colors"
process.stdin.on "data", (chunk) ->
    # proxy all stdin to console transparently (@todo make this optional)
    process.stdout.write chunk

    # we might well get multiple lines per chunk, so we have to split them out
    # line by line and augment each one before packing it all up to send on
    # to the queue
    lines = chunk.split "\n"

    final = []
    for line in lines
        if line != ''
            _line = JSON.parse line
            _line[1].identifier = identifier

            final.push _line

    push.send JSON.stringify(final) if final.length

# ensure we terminate properly when stdin's done
process.stdin.on "end", ->
    process.exit()
