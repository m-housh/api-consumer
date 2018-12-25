import XCTest
@testable import ApiConsumer

final class ApiConsumerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ApiConsumer().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
