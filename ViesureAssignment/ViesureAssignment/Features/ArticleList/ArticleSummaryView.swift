//
//  ArticleSummaryView.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import SwiftUI
import SwURL

struct ArticleSummaryView: View {
    
    var title: String
    var description: String
    var url: URL?
    
    var body: some View {
        HStack {
            if url != nil{
                RemoteImageView(url: url!).imageProcessing({ image in
                    return image
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(16.0)
                })
            }
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .lineLimit(1)
                Text(description)
                    .lineLimit(2)
            }
        }
    }
}
