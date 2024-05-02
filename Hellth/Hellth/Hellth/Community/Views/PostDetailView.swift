//
//  PostDetailView.swift
//  Hellth
//
//  Created by 박지혜 on 5/1/24.
//

import SwiftUI

struct PostDetailView: View {
    @StateObject var commentService: CommentService
    var post: Post
    
    init(post: Post) {
        self.post = post
        _commentService = StateObject(wrappedValue: CommentService(postId: post.id))
    }
    
    @State var inputComment: String = ""
    
    private let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd"
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // 카테고리
                
                // 글제목 
                Text("\(post.title)")
                    .font(.title)
                    .bold()
                HStack {
                    // 사용자 정보, 작성 시간
                    AsyncImage(url: post.photoURL) { image in
                        image
                            .resizable()
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundStyle(.blue)
                    }
                    .frame(width: 30, height: 30)
                    VStack {
                        Text("\(post.username ?? "익명") · \(post.date, formatter: dateFormat)")
                            .bold()
                        // 조회수, 공감수, 댓글수
                        
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
                // 글내용
                Text("\(post.body)")
                    .frame(maxHeight: .infinity, alignment: .top)
                // 공감 버튼
                
                Spacer()
                // 댓글 수
                Divider()
                
                // MARK: 추가 댓글 영역
                Text("댓글")
                    .bold()
                    .padding()
                // 댓글 작성자 정보, 작성 시간
                ScrollView {
                    VStack {
                        ForEach(commentService.comments) { comment in
                            HStack {
                                // 사용자 정보, 작성 시간
                                AsyncImage(url: comment.photoURL) { image in
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .foregroundStyle(.blue)
                                }
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 10)
                                Text("\(comment.username ?? "익명")")
                                    .bold()
                            }
                            .padding([.top, .bottom], 10)
                            // 댓글 내용
                            Text("\(comment.body)")
                                .padding(.leading, 30)
                                .padding(.bottom, 10)
                            // 조회수, 공감수, 댓글수, 날짜
                            HStack {
                                Button {
                                    commentService.updateCommentLikes(commentId: comment.id)
                                } label: {
                                    Image(systemName: comment.isLiked ? "heart.fill" : "heart")
                                        .foregroundStyle(comment.isLiked ? .pink: .primary)
                                    Text("\(comment.likes)")
                                        .foregroundStyle(Color(.systemGray))
                                }
                                
                                
                                // 대댓글 수(버튼)
                                Button {
                                    
                                } label: {
                                    Text("· 대댓글 달기")
                                        .foregroundStyle(Color(.systemGray))
                                }
                                Spacer()
                                Text("\(comment.date, formatter: dateFormat)")
                                    .foregroundStyle(Color(.systemGray))
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    }
                    .padding(.leading, 20)
                    .padding([.trailing, .bottom], 15)
                    
                    Divider()
                    // 댓글 입력
                    HStack {
                        VStack {
                            Button {
                                
                            } label: {
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .frame(width: 45, height: 40)
                                    .foregroundStyle(Color(.systemGray))
                                    .padding(5)
                            }
                        }
                        ZStack {
                            TextField("댓글을 입력해주세요", text: $inputComment)
                                .padding()
                                .frame(height: 50)
                                .background(Capsule().fill(Color(.systemGray5)))
                            HStack {
                                Spacer()
                                Button {
                                    commentService.addComment(date: Date(), body: inputComment, author: nil, username: nil, photoURL: nil)
                                } label: {
                                    Image(systemName: "arrow.up.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(inputComment.isEmpty ? Color(.systemGray) : .blue)
                                }
                                .padding()
                                .disabled(inputComment.isEmpty)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 10)
            .padding(20)
            .lineLimit(nil)
            .lineSpacing(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle("\(post.category)")
            .navigationBarTitleDisplayMode(.inline)
            }
        
        }
    
}

#Preview {
    PostDetailView(post: Post.sample[0])
}
