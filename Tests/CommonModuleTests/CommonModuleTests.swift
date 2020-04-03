//
//  CommonModuleTests.swift
//  CommonModuleTests
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import XCTest
@testable import CommonModule
@testable import ArticleModel

class CommonModuleTests: XCTestCase {
    
    var defaults: SharedUserDefaults?
    var data: Article?
    
    override func setUp() {
        resetDefaults()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func testFormatDate() {
        let stringDate = "6/25/2018"
        let incomingStringDate = DateConverter.convertDateTo(dateString: stringDate)
        XCTAssertEqual(incomingStringDate, "Sun, Dec 24, '17")
    }
    
    func testSharedUserDefaults() {
        resetDefaults()
        defaults = SharedUserDefaults()
        data = Article(id: 1,
                       title: "String",
                       articleDescription: "String",
                       author: "String",
                       releaseDate: "String",
                       image: URL(fileURLWithPath: "String"))
        
        let jsonData = try? JSONEncoder().encode(data)
        defaults?.articlesData = jsonData
        XCTAssertNotNil(defaults?.hasValue(forKey: String(describing: Article.self)))
        XCTAssertNotNil(defaults?.readValueForKey(key: String(describing: Article.self)))
    }
    
    func testPersistToDisc() {
        resetDefaults()
        data = Article(id: 2,
                       title: "String",
                       articleDescription: "String",
                       author: "String",
                       releaseDate: "String",
                       image: URL(fileURLWithPath: "String"))
        defaults = SharedUserDefaults()
        let jsonData = try? JSONEncoder().encode(data)
        defaults?.articlesData = jsonData
        
        defaults?.saveValueForKey(value: jsonData!, key: "articleKey")
        XCTAssertNotNil(defaults?.hasValue(forKey: "articleKey"))
    }
}

