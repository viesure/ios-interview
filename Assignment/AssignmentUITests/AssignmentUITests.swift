//
//  AssignmentUITests.swift
//  AssignmentUITests
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import XCTest

class AssignmentUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testArticlesSelection() {
        let app = XCUIApplication()
        app.activate()
        
        let cellCount = app.tables.cells.count
        XCTAssertTrue(cellCount > 0)
        
        let firstCell = app.tables.cells.element(boundBy: 0)
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: firstCell, handler: nil)

        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        app.navigationBars["Article details"].buttons["Articles"].tap()
        
        let randomCell = app.tables.cells.element(boundBy: 27)
        
        XCTAssertTrue(randomCell.exists)
        randomCell.tap()
        
        let maxReachedCell = app.tables.cells.element(boundBy: 65)
        XCTAssertFalse(maxReachedCell.exists)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
