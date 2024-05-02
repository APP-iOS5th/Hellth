//
//  AddPostView.swift
//  Hellth
//
//  Created by 박지혜 on 5/1/24.
//

import SwiftUI

struct AddPostView: View {
    @State var pickedCategory: Category = .exercise
    @State private var inputTitle: String = ""
    @State private var inputBody: String = ""
    @Environment(\.dismiss) var dismiss
    
    var service: PostsService?
    
    var body: some View {
        NavigationStack {
            VStack {
                // 글제목
                TextField("제목을 입력해주세요.", text: $inputTitle)
                    .padding()
                    .font(.title2)
                // 카테고리
                HStack {
                    Text("카테고리")
                        .padding(.leading, 10)
                    Picker("카테고리를 선택하세요.", selection: $pickedCategory) {
                        ForEach(Category.allCases.dropFirst(), id: \.self) { category in
                            Text(category.rawValue)
                        }
                    }
                    .frame(width: 300, alignment: .leading)
                    .tint(.blue)
                }
                
                // 글씨 꾸미기
                
                Divider()
                // 글내용
                TextField("내용을 입력해주세요.", text: $inputBody)
                    .padding()
                    .frame(maxHeight: .infinity, alignment: .top)
                    .background(
                        Rectangle()
                        .fill(Color(.systemGray5)))
                // 이미지 업로드
                VStack {
                    HStack {
                        Text("사진 등록 (선택)")
                        Spacer()
                        Text("· 최대 5장까지 가능!")
                    }
                    .padding(.bottom, 15)
                    .foregroundStyle(.gray)
                    HStack {
                        ZStack {
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(.systemGray5))
                                    .frame(width: 70, height: 70)
                                
                            }
                            Text("+")
                                .foregroundStyle(.gray)
                                .font(.largeTitle)
                        }
                        Spacer()
                    }
                }
                .padding(25)
                // 올리기 버튼
                Button {
                    service?.addPost(category: pickedCategory.rawValue, title: inputTitle, date: Date(), body: inputBody, author: nil, username: nil, photoURL: nil)
                } label: {
                    Text("글 올리기")
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 350, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                            .fill(.blue))
                }
                
            }
            .navigationTitle("\(pickedCategory.rawValue)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//#Preview {
//    AddPostView(service: nil)
//}
