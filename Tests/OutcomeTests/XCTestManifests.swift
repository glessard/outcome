import XCTest

extension OutcomeTests {
    static let __allTests = [
        ("testEquals", testEquals),
        ("testGetters", testGetters),
        ("testHashable", testHashable),
        ("testResult", testResult),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(OutcomeTests.__allTests),
    ]
}
#endif
