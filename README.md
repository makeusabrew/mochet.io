# Mocha + Socket.io = mochet.io
AKA view real time Mocha test results in your web browser

## What is it?

A way of viewing any number of remotely executed test suites run under
[Mocha](https://github.com/visionmedia/mocha) in real time from the
comfort of your browser.


## How does it work?

Currently mochet.io is comprised of two main parts:

* mochet.coffee - a client script which receives JSON input from Mocha and places it on a queue
* server.coffee - an express & socket.io server which pulls data off said queue, and pushes it out to all connected clients

## Why does it exist?

Partly because anything to do with socket.io is fun, as is using Mocha to test stuff. Mainly because
it feels like it might be vaguely useful when a bit more fully featured - the idea is to support real time
output from any number of currently executing test suites, navigable by the source machine they're
being run from. With some basic security measures in place this also lets users share test suites
remotely with anyone who might be interested, essentially proxying terminal test output to a constantly
updated web page.
