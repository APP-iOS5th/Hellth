//
//  Post.swift
//  Hellth
//
//  Created by 박지혜 on 5/1/24.
//

import Foundation

enum Category: String, CaseIterable {
    case total = "전체"
    case exercise = "운동"
    case diet = "다이어트"
}

struct Format {
    private lazy var dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    mutating func formatDate(_ date: Date) -> String {
        return dateFormat.string(from: date)
    }
}

struct Post: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var category: String
    var title: String
    var date: Date
    var body: String
    let author: String?
    let username: String?
    var photoURL: URL?
    var docId: String?
}

// 테스트 데이터
extension Post {
    static let sample: [Post] = [
        Post(category: "운동", title: "운동 루틴 공유", date: Date(), body: "루틴 공유해요오오오오오오오오오옹오오오오오오오오오오오오옹오오오오오옹오오오ㅗ오옹오ㅗ옹ㅇ오오ㅗㅇ오ㅗㅇ오오오ㅗ오오오오오오오옹", author: nil, username: nil, photoURL: nil, docId: nil),
        Post(category: "운동", title: "오운완~", date: Date(), body: "오늘도 운동 완료", author: nil, username: nil, photoURL: nil, docId: nil),
        Post(category: "다이어트", title: "오늘의 식단", date: Date(), body: "단백질", author: nil, username: nil, photoURL: nil, docId: nil),
        Post(category: "다이어트", title: "눈바디 체크", date: Date(), body: "살빠짐", author: nil, username: nil, photoURL: nil, docId: nil)
        ]
    

}
