module.exports = (params) ->
    suite = params.suite

    _wrapper    = $("[data-wrapper]")

    identifier = _wrapper.find suite.getDomString()

    console.log _wrapper, identifier

    if not identifier.length
        identifier = $("<div></div>")
        .attr("data-namespace", suite.namespace)
        .attr("data-title", suite.title)
        .attr("data-instance", suite.instance)
        .addClass("suite")

        _wrapper.append identifier

    h2 = $("<h2></h2>")
    .html(params.title)
    .append(" (<span data-current>0</span> / <span data-total>?</span>)")

    progress = $('<div class="progress progress-striped active"> <div class="bar" style="width: 0%;"></div> </div>')

    tests = $("<ul></ul>").attr("data-tests", "").addClass("tests")

    div = $("<div class=test-wrapper></div>").append(tests)

    identifier
    .append(h2)
    .append(progress)
    .append(div)
