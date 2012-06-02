assert = require "./lib/assert"

Suite = require "../client/models/suite"

testData =
    namespace: "my_namespace"
    title: "My Title"

describe "Suite model", ->
    suite = null

    describe "a newly instantiated object", ->
        before ->
            suite = new Suite testData, 1

        it "should return the correct DOM string", ->
            assert.equal "[data-namespace='my_namespace'][data-title='My Title'][data-instance='1']", suite.getDomString()

        it "should return the correct title", ->
            assert.equal "My Title", suite.getTitle()

        it "should return the correct full title", ->
            assert.equal "my_namespace - My Title", suite.getFullTitle()

        it "should return the correct identifier", ->
            assert.equal "my_namespace_My Title_1", suite.getIdentifier()

        it "should not be active", ->
            assert.equal false, suite.isActive()

        it "should not have any tests", ->
            assert.equal 0, suite.getTestCount()

        it "should have a total test count of zero", ->
            assert.equal 0, suite.getTotalTestCount()
        
        it "should be be zero percent complete", ->
            assert.equal 0, suite.getPercentComplete()

    describe "isActiveForIdentifier", ->
        before ->
            suite = new Suite testData, 1

        it "should return false when inactive", ->
            assert.equal false, suite.isActiveForIdentifier {namespace: "my_namespace", title: "My Title"}

        it "should return false when identifier does not match", ->
            suite.active = true

            assert.equal false, suite.isActiveForIdentifier {namespace: "other_namespace", title: "My Title"}

        it "should return true when active and identifier matches", ->
            suite.active = true

            assert.equal true, suite.isActiveForIdentifier {namespace: "my_namespace", title: "My Title"}

    describe "addTest", ->
        before ->
            suite = new Suite testData, 1

            suite.addTest {title:"foo", fullTitle:"bar", duration:1}
        
        it "should increment the test count", ->
            assert.equal 1, suite.getTestCount()

    describe "activate", ->
        before ->
            suite = new Suite testData, 1
            suite.activate()

        it "should make the suite active", ->
            assert.equal true, suite.isActive()

    describe "deactivate", ->
        before ->
            suite = new Suite testData, 1
            suite.active = true

            suite.deactivate()

        it "should make the suite inactive", ->
            assert.equal false, suite.isActive()
