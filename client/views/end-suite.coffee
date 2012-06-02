module.exports = (params) ->
    suite = params.suite

    _wrapper    = $("[data-wrapper]")
    domSuite = _wrapper.find suite.getDomString()

    if params.failures > 0
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

