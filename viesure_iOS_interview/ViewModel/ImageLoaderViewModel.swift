//
//  ImageLoaderViewModel.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import Foundation

class ImageLoaderViewModel: ObservableObject {
    @Published var data = Data()

    init(urlString: String) {
        let httpsURL = checkURLScheme(for: urlString)
        
        guard let url = URL(string: httpsURL) else { return }
        
        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        .resume()
    }
    
    ///Checks the url if it is in the https format. I font, change url string to conform to https protocol.
    private func checkURLScheme(for url: String) -> String {
        guard var comps = URLComponents(string: url) else { return url }
        comps.scheme = "https"
        guard let https = comps.string else { return url }
        return https
    }
}
