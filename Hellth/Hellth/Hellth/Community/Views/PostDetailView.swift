//
//  PostDetailView.swift
//  Hellth
//
//  Created by 박지혜 on 5/1/24.
//

import SwiftUI

struct PostDetailView: View {
    @StateObject var commentService: CommentService
    @StateObject var postService: PostsService = PostsService()
    var post: Post
    
    init(post: Post) {
        self.post = post
        _commentService = StateObject(wrappedValue: CommentService(postId: post.docId!))
    }
    
    @State private var inputComment: String = ""
    @State private var showingPostAlert: Bool = false
    @State private var showingCommentAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    private let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd"
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    // 글제목
                    Text("\(post.title)")
                        .font(.title)
                        .bold()
                    Spacer()
                    // 게시글 삭제
                    Button {
                        showingPostAlert = true
                    } label: {
                        Text("···")
                    }
                    .buttonStyle(.plain)
                    .alert(isPresented: $showingPostAlert) {
                        Alert(
                            title: Text("게시글 삭제"),
                            message: Text("삭제하시겠습니까?"),
                            primaryButton: .destructive(Text("확인")) {
                                // 삭제
                                Task {
                                    await postService.deletePost(postId: post.docId!)
                                    dismiss()
                                }
                            },
                            secondaryButton: .cancel(Text("취소"))
                        )
                    }
                }
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
                                Spacer()
                                // 댓글 삭제
                                Button {
                                    showingCommentAlert = true
                                } label: {
                                    Text("···")
                                }
                                .alert(isPresented: $showingCommentAlert) {
                                    Alert(
                                        title: Text("댓글 삭제"),
                                        message: Text("삭제하시겠습니까?"),
                                        primaryButton: .destructive(Text("확인")) {
                                            // 삭제
                                            Task {
                                                await commentService.deleteComment(docId: comment.docId!)
                                            }
                                        },
                                        secondaryButton: .cancel(Text("취소"))
                                    )
                                }
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
                    .padding([.trailing, .bottom], 20)
                    Divider()
                    // 댓글 입력
                    HStack {
                        VStack {
                            // 이미지 첨부
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
                                // 댓글 저장
                                Button {
                                    commentService.addComment(date: Date(), body: inputComment, author: nil, username: nil, photoURL: nil)
                                    inputComment = ""
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
            .navigationTitle("\(post.category)") // 카테고리
            .navigationBarTitleDisplayMode(.inline)
            }
        
        }
    
}

//#Preview {
//    PostDetailView(post: Post.sample[0])
//}
