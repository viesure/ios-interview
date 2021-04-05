//
//  DetailView.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import SwiftUI
import SwURL

struct DetailView: View {
    
    var articleIdentifier: Int
    @Environment(\.interactorContainer) var interactorContainer
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        ScrollView {
            if store.viewModels.articleDetail == nil {
                ProgressView()
            } else {
            if store.viewModels.articleDetail!.image != nil {
                RemoteImageView(url: store.viewModels.articleDetail!.image!).imageProcessing({ image in
                    return image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
            }
            HStack {
                Text(store.viewModels.articleDetail!.title)
                    .font(.body)
                    .bold()
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                Spacer()
            }
            HStack {
                Spacer()
                Text(store.viewModels.articleDetail!.release_date)
                    .font(.caption)
            }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
            HStack {
                Text(store.viewModels.articleDetail!.description)
            }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            HStack {
                Text(store.viewModels.articleDetail!.author)
                    .font(.caption)
                Spacer()
            }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
            Spacer()
            }
        }.navigationBarTitle("Detail", displayMode: .automatic).onAppear {
            interactorContainer?.articleDetailInteractor.fetchArticle(with: articleIdentifier)
        }
    }
}
