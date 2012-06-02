###
# A suite is a group of tests which can be uniquely identified by a combination
# of three properties: namespace+title+instance
# e.g.
# namespace = my_linux_computer
# title = My PRoject
# instance = 1, 2, 3...
###

class Suite
    constructor: (data, instance) ->
        @namespace = data.namespace
        @title     = data.title
        @instance  = instance
        @active = false

    getTitle: ->
        @title

    getDomString: ->
        "[data-namespace='#{@namespace}'][data-title='#{@title}'][data-instance='#{@instance}']"

    isActive: ->
        @active

    isActiveForIdentifier: (identifier) ->
        @active and @namespace is identifier.namespace and @title is identifier.title

module.exports = Suite
