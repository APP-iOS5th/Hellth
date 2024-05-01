//
//  PostSummaryView.swift
//  Hellth
//
//  Created by 박지혜 on 5/1/24.
//

import SwiftUI

struct PostSummaryView: View {
    var post: Post
    var category: String
    private let format: Date.FormatStyle = .dateTime.month(.wide).day().year()
    
    var body: some View {
        VStack {
            HStack {
                Text("\(post.category)·\(post.username ?? "익명")·\(post.date, format: format)")
                
            }
        }
    }
}

#Preview {
    PostSummaryView(post: Post.sample[0], category: "다이어트")
}
