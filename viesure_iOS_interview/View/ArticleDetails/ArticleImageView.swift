//
//  ArticleImageView.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import SwiftUI

struct ArticleImageView: View {
        
    private let image: Image
    
    init(_ image: Image) {
        self.image = image
    }
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct ArticleImageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImageView(Image("turtlerock"))
    }
}
