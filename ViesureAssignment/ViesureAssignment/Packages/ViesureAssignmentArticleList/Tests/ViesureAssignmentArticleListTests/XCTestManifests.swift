import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ViesureAssignmentArticleListTests.allTests),
    ]
}
#endif
