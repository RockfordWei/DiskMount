import XCTest
@testable import shell
import Foundation
class shellTests: XCTestCase {
    func testExample() {
       do {
        let a = try shell("hdiutil attach /tmp/vbox.dmg")
        XCTAssertTrue(a.contains("/dev/disk2s1"))
        print(a)
        let b = try shell("hdiutil detach /dev/disk2s1")
        XCTAssertTrue(b.contains("disk2"))
        print(b)
       }catch {
        XCTFail(error.localizedDescription)
      }
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
