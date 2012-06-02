assert = require "./lib/assert"

Suite = require "../client/models/suite"

describe "Suite model", ->
    suite = null

    describe "a newly instantiated object", ->
        before ->
            data =
                namespace: "my_namespace"
                title: "My Title"

            suite = new Suite data, 1

        it "should return the correct DOM string", ->
            assert.equal "[data-namespace='my_namespace'][data-title='My Title'][data-instance='1']", suite.getDomString()

        it "should return the correct title", ->
            assert.equal "My Title", suite.getTitle()

        it "should not be active", ->
            assert.equal false, suite.isActive()

        it "should not any tests", ->
            assert.equal 0, suite.getTestCount()

    describe "isActiveForIdentifier", ->

        it "should return false when inactive", ->
            id =
                namespace: "my_namespace"
                title: "My Title"
            assert.equal false, suite.isActiveForIdentifier id

        it "should return false when identifier does not match", ->
            suite.active = true
            id =
                namespace: "other_namespace"
                title: "My Title"
            assert.equal false, suite.isActiveForIdentifier id

        it "should return true when active and identifier matches", ->
            id =
                namespace: "my_namespace"
                title: "My Title"
            assert.equal true, suite.isActiveForIdentifier id

    describe "addTest", ->

        before ->
            suite.addTest {title:"foo", fullTitle:"bar", duration:1}
        
        it "should increment the test count", ->
            assert.equal 1, suite.getTestCount()
