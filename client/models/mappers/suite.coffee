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

    findActive: (identifier) ->
        return suite for suite in suites when suite.isActiveForIdentifier identifier

module.exports = SuiteMapper
