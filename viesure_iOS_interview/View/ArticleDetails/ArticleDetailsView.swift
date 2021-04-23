//
//  ArticleDetailsView.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import SwiftUI

struct ArticleDetailsView: View {
    
    private let article: ArticleModel
    
    init(selectedArticle: ArticleModel) {
        self.article = selectedArticle
    }
    
    var body: some View {
        ScrollView {

            VStack(alignment: .leading) {
                ArticleImageView(Image("turtlerock"))
                
                ArticleTextDetailsView(article)
                    .padding([.leading, .bottom, .trailing])
            }
       
        }
    }
}

struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailsView(selectedArticle: ArticleModel(
            id: 1,
            title: "Realigned multimedia framework",
            description: "nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vitae mattis nibh ligula",
            author: "sfolley0@nhs.uk",
            release_date: "6/25/2018",
            image: "http://dummyimage.com/366x582.png/5fa2dd/ffffff")
        )
    }
}
