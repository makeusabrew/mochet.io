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

        suite.addTest data

        domSuite = _wrapper.find suite.getDomString()

        domSuite.find("[data-current]").html suite.getTestCount()
        
        symbol = if type is "pass" then "✔" else "✘"

        li = $("<li><span class='#{type}'>#{symbol}</span> #{data.fullTitle}</li>")

        ul = domSuite.find("ul.tests")
        ul.append(li)

        domSuite.find(".test-wrapper").scrollTop(ul.height())

        pc = Math.round suite.getPercentComplete()

        domSuite.find(".progress .bar").css("width", "#{pc}%")

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

        domSuite = _wrapper.find suite.getDomString()

        domSuite.find("[data-total]").html suite.getTotalTestCount()

        active = $("ul[data-active-suites]")
        active.find("[data-placeholder]").remove()

        li = $("<li></li>")
        .attr("data-identifier", suite.getIdentifier())
        .html(suite.getFullTitle())

        active.append li

    endSuite: (data) ->
        suite = SuiteMapper.findActive data.identifier
        return if not suite

        domSuite = _wrapper.find suite.getDomString()

        if data.failures > 0
            domSuite.find(".progress").addClass("progress-warning")
        else
            domSuite.find(".progress").addClass("progress-success")

        domSuite.find(".progress").removeClass("active")

        active = $("ul[data-active-suites]")
        active.find("[data-placeholder]").remove()

        li = active.find("[data-identifier='#{suite.getIdentifier()}']").remove()

        if active.find("li").length is 1
            active.append("<li data-placeholder>None</li>")

        recent = $("ul[data-recent-suites]")
        recent.find("[data-placeholder]").remove()

        recent.append li

module.exports = PageController
