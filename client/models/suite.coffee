###
# A suite is a group of tests which can be uniquely identified by a combination
# of three properties: namespace+title+instance
# e.g.
# namespace = my_linux_computer
# title = My PRoject
# instance = 1, 2, 3...
###

Test = require "./test"

class Suite
    constructor: (data, instance) ->
        @namespace = data.namespace
        @title     = data.title
        @instance  = instance
        @active    = false
        @tests     = []
        @totalTests= 0

    getTitle: ->
        @title

    getFullTitle: ->
        "#{@namespace} - #{@title}"

    getIdentifier: ->
        "#{@namespace}_#{@title}_#{@instance}"

    getDomString: ->
        "[data-namespace='#{@namespace}'][data-title='#{@title}'][data-instance='#{@instance}']"

    isActive: ->
        @active

    isActiveForIdentifier: (identifier) ->
        @active and @namespace is identifier.namespace and @title is identifier.title

    addTest: (data, type) ->
        test = new Test data, type
        @tests.push test
        return test

    getTestCount: ->
        @tests.length

    getTotalTestCount: ->
        @totalTests

    getPercentComplete: ->
        return 0 if not @getTotalTestCount()

        (@getTestCount() / @getTotalTestCount()) * 100

    activate: ->
        @active = true

    deactivate: ->
        @active = false

module.exports = Suite
