_wrapper   = $("[data-wrapper]")
_current   = {}

PageController =
    addTest: (type, data) ->
        suite = PageController.findSuite data.namespace
        return if suite.length is 0

        tmp = _current[data.namespace.identifier][data.namespace.title] += 1

        suite.find("[data-current]").html(tmp)
        
        symbol = if type is "pass" then "✔" else "✘"

        li = $("<li><span class='#{type}'>#{symbol}</span> #{data.fullTitle}</li>")
        ul = suite.find("ul.tests")
        ul.append(li)
        suite.find(".test-wrapper").scrollTop(ul.height())

        total = parseInt(suite.find("[data-total]").html())

        pc = Math.round((tmp / total) * 100)

        suite.find(".progress .bar").css("width", "#{pc}%")

    createNamespace: (data) ->
        identifier = _wrapper.find("[data-identifier='#{data.identifier}']")

        if not identifier.length
            identifier = $("<div></div>").attr("data-identifier", data.identifier)
            _wrapper.append identifier

        _current[data.identifier] = {} if not _current[data.identifier]

        _current[data.identifier][data.title] = 0

        suite = identifier.find("[data-title='#{data.title}']").remove()

        suite = $("<div></div>").attr("data-title", data.title).addClass("suite")

        h2 = $("<h2></h2>")
        .html(data.title)
        .append(" (<span data-current>0</span> / <span data-total>?</span>)")

        progress = $('<div class="progress progress-striped active"> <div class="bar" style="width: 0%;"></div> </div>')

        tests = $("<ul></ul>").attr("data-tests", "").addClass("tests")

        div = $("<div class=test-wrapper></div>").append(tests)

        suite
        .append(h2)
        .append(progress)
        .append(div)

        identifier.append suite

    findSuite: (data) ->
        return _wrapper.find("[data-identifier='#{data.identifier}'] [data-title='#{data.title}']")

    startSuite: (data) ->
        suite = PageController.findSuite data.namespace
        return if suite.length is 0

        suite.find("[data-total]").html(data.total)

        active = $("ul[data-active-suites]")
        active.find("[data-placeholder]").remove()

        li = $("<li></li>").attr("data-namespace", data.namespace.identifier+"_"+data.namespace.title).html(data.namespace.identifier+ " - "+data.namespace.title)
        active.append li

    endSuite: (data) ->
        suite = PageController.findSuite data.namespace
        return if suite.length is 0

        if data.failures > 0
            suite.find(".progress").addClass("progress-warning")
        else
            suite.find(".progress").addClass("progress-success")

        suite.find(".progress").removeClass("active")

        active = $("ul[data-active-suites]")
        active.find("[data-placeholder]").remove()

        active.find("[data-namespace='#{data.namespace.identifier}_#{data.namespace.title}']").remove()

        if active.find("li").length is 1
            active.append("<li data-placeholder>None</li>")

        recent = $("ul[data-recent-suites]")
        recent.find("[data-placeholder]").remove()

        li = $("<li></li>").attr("data-namespace", data.namespace.identifier+"_"+data.namespace.title).html(data.namespace.identifier+ " - "+data.namespace.title)
        recent.append li

module.exports = PageController
