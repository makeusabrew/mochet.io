PageController = require "../controllers/page"

UrlRouter =
    load: (app) ->
        PageController.init app

        app.get "/", (req, res) ->
            PageController.index req, res

module.exports = UrlRouter
