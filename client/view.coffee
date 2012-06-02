# we can't dynamically require with browserify, so we have to take
# the hit here and map physical files to arbitrary strings instead
viewMap =
    "suite:create": require "./views/create-suite.coffee"

View =
    render: (view, data) ->
        viewMap[view](data)

module.exports = View
