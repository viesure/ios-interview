//
//  ArticlesView.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import SwiftUI

struct ArticlesView: View {
    @ObservedObject var articlesViewModel = ArticlesViewModel()
    @ObservedObject var connectivityViewModel = ConnectivityViewModel()
    
    var body: some View {
        NavigationView {
            List(articlesViewModel.articles) {article  in
                ArticleRowView(article)
                
                NavigationLink(destination: ArticleDetailsView(selectedArticle: article)) {
                    ArticleRowView(article)
                }
                .frame(width: 0, height: 0)
                .opacity(0)
            }
            .navigationBarTitle("Articles")
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
        }
        .alert(isPresented: $connectivityViewModel.showingConnectivityProblemsAlert,
               content: connectivityViewModel.connectivityProblemsAlert)
        .alert(isPresented: $articlesViewModel.showingDataSynchronisationFailureAlert,
               content: articlesViewModel.dataSynchronisationFailureAlert)
        
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
