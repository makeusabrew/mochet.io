assert = require "./lib/assert"

Suite = require "../client/models/suite"

describe "Suite model", ->
    suite = null

    before ->
        data =
            namespace: "my_namespace"
            title: "My Title"

        suite = new Suite data, 1

    it "should return the correct DOM string", ->
        assert.equal "[data-namespace='my_namespace'][data-title='My Title'][data-instance='1']", suite.getDomString()

    it "should return the correct title", ->
        assert.equal "My Title", suite.getTitle()
