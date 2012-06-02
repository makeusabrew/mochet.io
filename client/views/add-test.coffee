module.exports = (params) ->
    suite = params.suite
    test  = params.test

    _wrapper    = $("[data-wrapper]")
    domSuite = _wrapper.find suite.getDomString()

    domSuite.find("[data-current]").html suite.getTestCount()
    
    symbol = if test.isPass() then "✔" else "✘"

    li = $("<li><span class='#{test.type}'>#{symbol}</span> #{test.fullTitle}</li>")

    ul = domSuite.find("ul.tests")
    ul.append(li)

    domSuite.find(".test-wrapper").scrollTop(ul.height())

    pc = Math.round suite.getPercentComplete()

    domSuite.find(".progress .bar").css("width", "#{pc}%")
    $("li[data-identifier='#{suite.getIdentifier()}'] .badge").html("#{pc}%")
