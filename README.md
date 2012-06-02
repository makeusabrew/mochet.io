# Mocha + Socket.io = mochet.io
AKA view real time Mocha test results in your web browser

## What is it?

A way of viewing any number of remotely executed test suites run under
[Mocha](https://github.com/visionmedia/mocha) in real time from the
comfort of your browser.


## How does it work?

Currently mochet.io is comprised of three main parts:

* mochet.coffee - a script which receives JSON input from Mocha and places it on a queue
* server.coffee - an express & socket.io server which pulls data off said queue, and pushes it out to all connected clients
* client.coffee - a JavaScript client which interprets data from the server and attempts to render pretty things in your browser

## Why does it exist?

Partly because anything to do with socket.io is fun, as is using Mocha to test stuff. Mainly because
it feels like it might be vaguely useful when a bit more fully featured - the idea is to support real time
output from any number of currently executing test suites, navigable by the source machine they're
being run from. With some basic security measures in place this also lets users share test suites
remotely with anyone who might be interested, essentially proxying terminal test output to a constantly
updated web page.

## What does it look like?

Not a lot at the moment. Currently a bit like this:

![mochet.io](http://dl.dropbox.com/u/7898316/mochet.png "mochet.io")

## Who made it?

[@makeusabrew](http://twitter.com/makeusabrew)

## How do I run it?

You'll need to install ZeroMQ since that's how mochet communicates with the server.

### Start the web server

```coffee ./server.coffee```

### Pipe your Mocha test output through mochet.io

From the project you want to test:

```mocha -R json-stream | coffee /path/to/mochet.io/mochet.coffee "My Project Name"```

Mochet reads from stdin, so the only argument it needs is some way of identifying
the project you're testing. It'll create an automatic namespace for tests being
sent from each different machine by using its hostname and OS version.

## License

(The MIT License)

Copyright (C) 2012 by Nick Payne <nick@kurai.co.uk>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE
