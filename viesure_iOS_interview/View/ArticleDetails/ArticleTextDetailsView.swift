//
//  ArticleTextDetailsView.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import SwiftUI

struct ArticleTextDetailsView: View {
    
    @ObservedObject var dateViewModel: DateViewModel
    
    private let article: ArticleModel
        
    init(_ article: ArticleModel) {
        self.article = article
        self.dateViewModel = DateViewModel(date: self.article.release_date)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(article.title)
                .font(.headline)

            HStack {
                Spacer()
                Text(dateViewModel.date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 15.0)
            }
            
            Text(article.description)
                .foregroundColor(.secondary)
                .lineLimit(nil)
                .padding(.bottom, 15.0)
                
            HStack {
                Text("Author: ")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                Text(article.author)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
        }
        
    }
}

struct ArticleTextDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleTextDetailsView(ArticleModel(
            id: 1,
            title: "Realigned multimedia framework",
            description: "nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vitae mattis nibh ligula",
            author: "sfolley0@nhs.uk",
            release_date: "6/25/2018",
            image: "http://dummyimage.com/366x582.png/5fa2dd/ffffff")
        )
    }
}
