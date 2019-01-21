//
//  SocializaTests.swift
//  SocializaTests
//
//  Created by Jose Luis Fernandez-Mayoralas on 10/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import XCTest
@testable import Socializa

class SocializaTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertToken() {
        let token = "EAAHnBOW3xZAABACzoKAZAS2TyT857hVrD8r8JZBLXtKRdFvk3KGFPfTaztGIZAUZBZAFIXfGqNGtGvQCyUNttcIaQUnzMJiTbK5HXs7x4F2jFrJGhO8JeKeZBmg2NWuikx5ZBmHSECZAcjJtSAziL4zGgaTPmtZA2tPoxlZAM02MjXBqv5Ly31Rgy7g498GNZAR3Y7PNa8nC5SDznht4yBRcbOxpscCYY14jGiwZD"
        
        SocializaBackend.shared.convertToken(token, platform: .facebook) { (result, error) in
            XCTAssertEqual(result!.access_token, "ACCESS_TOKEN")
        }
    }
}
