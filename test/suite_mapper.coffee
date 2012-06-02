assert = require "./lib/assert"

SuiteMapper = require "../client/models/mappers/suite"

testData =
   namespace: "my_namespace"
   title: "My Title"

describe "Suite mapper", ->

    describe "createSuite", ->
        suite = null

        before ->
            suite = SuiteMapper.createSuite testData

        it "should return a suite with the correct instance", ->
            assert.equal 1, suite.instance

        it "should return a suite with the correct DOM string", ->
            assert.equal "[data-namespace='my_namespace'][data-title='My Title'][data-instance='1']", suite.getDomString()

        it "should return a suite with the correct title", ->
            assert.equal "My Title", suite.getTitle()
