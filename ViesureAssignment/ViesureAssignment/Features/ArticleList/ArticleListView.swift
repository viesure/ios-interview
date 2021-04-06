//
//  ContentView.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import SwiftUI
import ViesureAssignmentArticleDetail
import ViesureAssignmentCommon

struct ArticleListView: View {
    @Environment(\.interactorContainer) var interactorContainer
    @EnvironmentObject var store: AppStore
    @State var shouldLoadData = true
    
    var body: some View {
        NavigationView {
            List(store.viewModels.articles) { model in
                NavigationLink(
                    destination: DetailView(articleIdentifier: model.id),
                    label: {
                        ArticleSummaryView(title: model.title,
                                           description: model.description,
                                           url: model.image)
                    })
                
            }.onAppear(perform: {
                if shouldLoadData == true {
                    interactorContainer?.articleInteractor.fetchArticles()
                }
                shouldLoadData = false
            })
            .navigationBarTitle("Articles")
        }.alert(isPresented: $store.errors.articleFetchFailure) {
            Alert(title: Text("Error"), message: Text("Oops Somthing Went Wrong"), dismissButton: .default(Text("OK")) {
                self.interactorContainer?.articleInteractor.resetErrors()
            })
        }
    }
}
