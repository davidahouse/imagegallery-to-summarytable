import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(imagegallery_to_summarytableTests.allTests),
    ]
}
#endif
