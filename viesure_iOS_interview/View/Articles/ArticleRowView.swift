//
//  ArticleRowView.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import SwiftUI

struct ArticleRowView: View {
    
    private let article: ArticleModel
    
    init(_ article: ArticleModel) {
        self.article = article
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image("turtlerock")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    .padding(.bottom, 3.0)
                
                Text(article.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.sRGB, white: 0, opacity: 0.05))
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(ArticleModel(
            id: 1,
            title: "Realigned multimedia framework",
            description: "nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vitae mattis nibh ligula",
            author: "sfolley0@nhs.uk",
            release_date: "6/25/2018",
            image: "http://dummyimage.com/366x582.png/5fa2dd/ffffff")
        )
    }
}
