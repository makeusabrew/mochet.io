# we can't dynamically require with browserify, so we have to take
# the hit here and map physical files to arbitrary strings instead
viewMap =
    "suite:create"   : require "./views/create-suite.coffee"
    "suite:start"    : require "./views/start-suite.coffee"
    "suite:end"      : require "./views/end-suite.coffee"
    "suite:add_test" : require "./views/add-test.coffee"

View =
    render: (view, data) ->
        viewMap[view](data)

module.exports = View
