###
# PageController is a bit of a bad name for this, so it'll probably get renamed
# at some point. SuiteController perhaps?
###

SuiteMapper = require "../models/mappers/suite"
View        = require "../view"

_wrapper    = $("[data-wrapper]")

suites = []

PageController =
    addTest: (type, data) ->
        suite = SuiteMapper.findActive data.identifier
        return if not suite

        test = suite.addTest data, type

        params =
            suite: suite
            test: test
        View.render "suite:add_test", params

    createSuite: (data) ->
        suite = SuiteMapper.createSuite data

        suite.activate()

        params       = data
        params.suite = suite
        View.render "suite:create", params

    startSuite: (data) ->
        suite = SuiteMapper.findActive data.identifier
        return if not suite

        # @todo setter?
        suite.totalTests = data.total

        params       = data
        params.suite = suite
        View.render "suite:start", params

    endSuite: (data) ->
        suite = SuiteMapper.findActive data.identifier
        return if not suite

        params       = data
        params.suite = suite
        View.render "suite:end", params

module.exports = PageController
