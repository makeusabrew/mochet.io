assert = require "./lib/assert"

Suite = require "../client/models/suite"

describe "Suite model", ->
    suite = null

    before ->
        data =
            namespace: "my_namespace"
            title: "my_title"

        suite = new Suite data, 1

    it "should return the correct DOM string", ->
        assert.equal "[data-namespace='my_namespace'][data-title='my_title'][data-instance='1']", suite.getDomString()
