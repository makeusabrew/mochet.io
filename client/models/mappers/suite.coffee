Suite = require "../suite"
suites = []

SuiteMapper =
    createSuite: (data) ->
        instance = suites.length + 1
        suite = new Suite data, instance
        suites.push suite

        return suite

    findAll: ->
        return suites

    # terminology: an "identifier" is really just a namespace+title... for now
    findForIdentifier: (identifier) ->
        return suite for suite in suites when suite.namespace

module.exports = SuiteMapper
