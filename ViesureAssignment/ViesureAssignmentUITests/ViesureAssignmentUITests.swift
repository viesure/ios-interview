//
//  ViesureAssignmentUITests.swift
//  ViesureAssignmentUITests
//
//  Created by Kurt Jacobs on 04.04.21.
//

import XCTest

class ViesureAssignmentUITests: XCTestCase {

    // Some more work should be done here with regard to using accessiblity and seperating these into distinct tests. Since this application is quite small it did not make sense at the moment.
    
    func testUI() throws {
        let app = XCUIApplication()
        app.launchEnvironment = ["isUITesting":"true"]
        app.launch()
        
        let firstCell = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.label == "This is a title, This is a description")
        firstCell.tap()
    
        XCTAssertTrue(app.staticTexts["This is a title"].exists)
        XCTAssertTrue(app.staticTexts["Thu, Jan 25, '18"].exists)
        XCTAssertTrue(app.staticTexts["This is a description"].exists)
        XCTAssertTrue(app.staticTexts["Author: Kurt Jacobs"].exists)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertEqual(app.tables.cells.count, 1)
    }
}
