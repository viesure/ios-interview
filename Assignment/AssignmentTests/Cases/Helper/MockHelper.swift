//
//  MockHelper.swift
//  AssignmentTests
//
//  Created by Stefan Andric on 4/3/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import Foundation

class MockHelper {
    var articleData: Data {
        return getData(name: "Article")
    }
    
    var articlesData: Data {
        return getData(name: "Articles")
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm/dd/yyyy"
        formatter.locale = .current
        return formatter
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
    
    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
}
