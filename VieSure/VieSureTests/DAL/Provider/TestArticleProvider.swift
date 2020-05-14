//
//  TestArticleProvider.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
@testable import VieSure

class TestArticleProvider: TestBaseProvider, ArticleProviding {

    var result: ProviderResult<[Article]>!

    func fetchArticles(cacheStrategy: CacheStrategy, completion: @escaping (ProviderResult<[Article]>) -> Void) {
        executeDelayed {
            completion(self.result)
        }
    }

    static func articles() -> (data: Data, articles: [Article])? {
        let jsonString: String = "[{\"id\":1,\"title\":\"Realigned multimedia framework\",\"description\":\"nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula\",\"author\":\"sfolley0@nhs.uk\",\"release_date\":\"6/25/2018\",\"image\":\"http://dummyimage.com/366x582.png/5fa2dd/ffffff\"},{\"id\":2,\"title\":\"Versatile 6th generation definition\",\"description\":\"a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in\",\"author\":\"ndanet1@sohu.com\",\"release_date\":\"9/28/2019\",\"image\":\"http://dummyimage.com/573x684.bmp/cc0000/ffffff\"}]"
        let data: Data = jsonString.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.vieSureDateFormatter)

        do {
            let _object = try decoder.decode([Article].self, from: data)
            return (data: data, articles: _object)

        } catch {
            return nil
        }
    }

}
