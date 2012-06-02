assert = require "./lib/assert"

Test = require "../client/models/test"

testData =
    title: "a sample test"
    fullTitle: "When running a sample test"
    duration: 100

describe "Test model", ->
    test = null

    describe "a newly instantiated object with a pass type", ->
        before ->
            test = new Test testData, "pass"

        it "return true from isPass", ->
            assert.ok test.isPass()
