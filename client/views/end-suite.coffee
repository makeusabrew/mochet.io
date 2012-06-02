module.exports = (params) ->
    suite = params.suite

    _wrapper    = $("[data-wrapper]")
    domSuite = _wrapper.find suite.getDomString()

    domSuite.find(".progress").removeClass("active")

    active = $("ul[data-active-suites]")
    active.find("[data-placeholder]").remove()

    li = active.find("[data-identifier='#{suite.getIdentifier()}']").remove()

    if active.find("li").length is 1
        active.append("<li data-placeholder>None</li>")

    recent = $("ul[data-recent-suites]")
    recent.find("[data-placeholder]").remove()

    badge = li
    .find(".badge")
    .removeClass("badge-info")
    
    if suite.success()
        badge.addClass("badge-success").html("ok")
        domSuite.find(".progress").addClass("progress-success")
    else
        badge.addClass("badge-important").html("fail")
        domSuite.find(".progress").addClass("progress-danger")

    recent.append li

