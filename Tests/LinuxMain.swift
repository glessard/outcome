import XCTest

import outcomeTests

var tests = [XCTestCaseEntry]()
tests += outcomeTests.allTests()
XCTMain(tests)