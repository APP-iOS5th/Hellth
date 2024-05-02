//
//  PostSummaryView.swift
//  Hellth
//
//  Created by 박지혜 on 5/1/24.
//

import SwiftUI

struct PostSummaryView: View {
    var post: Post
    private let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // 카테고리, 닉네임, 작성 시간
                HStack {
                    Text("\(post.category)")
                        .font(.headline)
                    Text("· \(post.username ?? "익명") · \(post.date, formatter: dateFormat)")
                        .font(.subheadline)
                }
                .padding(.bottom, 30)
                // 글내용
                Text(post.title)
                    .font(.title3)
                    .padding(.bottom, 20)
                // 조회수, 공감수, 댓글수
            }
            Spacer()
            VStack {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .frame(width: 60, height: 50)
                    .foregroundStyle(.gray)
            }
        }
        .padding(30)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.gray, lineWidth: 2))
    }
}


//#Preview {
//    PostSummaryView(post: Post.sample[0])
//}
