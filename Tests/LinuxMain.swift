import XCTest

import outcomeTests

var tests = [XCTestCaseEntry]()
tests += outcomeTests.__allTests()

XCTMain(tests)
