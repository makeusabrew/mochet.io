###
{
    "title":"should show as in stock",
    "fullTitle":"Product tests When viewing a product page should show as in stock",
    "duration":5,
    "namespace":{
        "title":"Test Project",
        "identifier":"nick-desktop_linux_3.0.0-20-generic-pae"
    }
}
###

class Test
    constructor: (data, type) ->
        @title     = data.title
        @fullTitle = data.fullTitle
        @duration  = data.duration
        @type      = type

    isPass: ->
        return @type is "pass"

module.exports = Test
