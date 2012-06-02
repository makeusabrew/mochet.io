module.exports = (params) ->
    suite = params.suite

    _wrapper    = $("[data-wrapper]")

    domSuite = _wrapper.find params.suite.getDomString()

    domSuite.find("[data-total]").html params.suite.getTotalTestCount()

    active = $("ul[data-active-suites]")
    active.find("[data-placeholder]").remove()

    li = $("<li></li>")
    .attr("data-identifier", params.suite.getIdentifier())
    .html("<a href=#>#{suite.getFullTitle()} <span class='badge badge-info'></span></a>")

    active.append li
