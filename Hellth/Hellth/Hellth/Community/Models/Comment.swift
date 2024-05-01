//
//  Comment.swift
//  Hellth
//
//  Created by 박지혜 on 5/1/24.
//

import Foundation

struct Comment: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var date: Date
    var body: String
    let author: String?
    let username: String?
    var photoURL: URL?
    var docId: String?
}

extension Comment {
    static let sample: [Comment] = [
        Comment(date: Date(), body: "오 멋진데요~", author: nil, username: nil, photoURL: nil, docId: nil),
        Comment(date: Date(), body: "오늘도 화이팅!", author: nil, username: nil, photoURL: nil, docId: nil)
        ]
}
