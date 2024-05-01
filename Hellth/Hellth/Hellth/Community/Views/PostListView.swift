//
//  PostListView.swift
//  Hellth
//
//  Created by 박지혜 on 5/1/24.
//

import SwiftUI

struct PostListView: View {
    @State var isTotalPressed: Bool = true
    @State var isExercisePressed: Bool = false
    @State var isDietPressed: Bool = false
    
    @State var category: Category = .total {
        didSet {
            switch category {
            case .total:
                isTotalPressed = true
                isExercisePressed = false
                isDietPressed = false
            case .exercise:
                isTotalPressed = false
                isExercisePressed = true
                isDietPressed = false
            case .diet:
                isTotalPressed = false
                isExercisePressed = false
                isDietPressed = true
            }
        }
    }
    
    var posts: [Post]
    
    var body: some View {
        NavigationStack {
            HStack {
                // 카테고리
                ForEach(Category.allCases, id: \.self) { cat in
                    Button (action: {
                        // 클릭 시 카테고리 필터링
                        category = cat
                        NavigationLink(value: )
//                        showPostSummary(postCategory: cat.rawValue)
                    }) {
                        Text("\(cat.rawValue)")
                            .padding(5)
                    }
                    .tint(tintColor(for: cat))
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
                .padding(5)
                Spacer()
            }
            // 타이틀
            .navigationTitle("커뮤니티")
            .padding(.leading, 20)
            
            // 검색창
            
            // 게시글 리스트
            
            
            
            // 게시글 추가 버튼
            
            // 게시글 삭제
            
        }
        .padding()
    }
    
    // 카테고리 버튼색 지정
    private func tintColor(for category: Category) -> Color {
        switch category {
        case .total:
            return isTotalPressed ? .blue : .black
        case .exercise:
            return isExercisePressed ? .blue : .black
        case .diet:
            return isDietPressed ? .blue : .black
        }
    }
    
    func showPostSummary(postCategory: String) -> some View {
        List(posts) { post in
            PostSummaryView(post: post, category: postCategory)
        }
//        .listStyle(.insetGrouped)
    }
}

#Preview {
    PostListView(posts: Post.sample)
}
