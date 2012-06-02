assert = require "./lib/assert"

SuiteMapper = require "../client/models/mappers/suite"

testData =
   namespace: "my_namespace"
   title: "My Title"

describe "Suite mapper", ->
    suite = null

    describe "createSuite", ->

        before ->
            suite = SuiteMapper.createSuite testData

        it "should return a suite with the correct instance", ->
            assert.equal 1, suite.instance

        it "should return a suite with the correct DOM string", ->
            assert.equal "[data-namespace='my_namespace'][data-title='My Title'][data-instance='1']", suite.getDomString()

        it "should return a suite with the correct title", ->
            assert.equal "My Title", suite.getTitle()

    describe "findAll", ->
        
        it "should return the correct number of suites", ->
            assert.equal 1, SuiteMapper.findAll().length

    describe "findActive", ->
        
        it "should return null for no active match", ->
            assert.equal null, SuiteMapper.findActive testData
