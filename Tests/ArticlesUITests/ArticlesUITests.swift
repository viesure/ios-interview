//
//  ArticlesUITests.swift
//  ArticlesUITests
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import XCTest

class ArticlesUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func waitForElementToAppear(_ element: XCUIElement) {
        let result = element.waitForExistence(timeout: 3)
        guard result else {
            XCTFail("Element does not appear")
            return
        }
    }
    
    func testArticlesViewControllerExist() {
        XCUIApplication().launch()
        waitForElementToAppear(XCUIApplication().otherElements["ArticlesViewController"])
    }
    
    func testArticleDetailViewExist() {
        let cellCount = app.tables.cells.count
        XCTAssertTrue(cellCount > 0)
        
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        waitForElementToAppear(XCUIApplication().otherElements["ArticleDetailView"])
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch application
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
