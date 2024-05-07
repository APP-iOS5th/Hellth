//
//  CommentService.swift
//  Hellth
//
//  Created by 박지혜 on 5/2/24.
//

import Firebase
import FirebaseFirestore

//@MainActor
class CommentService: ObservableObject {
    @Published var comments: [Comment]
    
    private let dbCollection: CollectionReference
    private var listener: ListenerRegistration?
    
    init(postId: String) {
        self.comments = []
        self.dbCollection = Firestore.firestore().collection("posts/\(postId)/comments")
        startRealtimeUpdates()
    }
    
    private func startRealtimeUpdates() {
        listener = dbCollection.addSnapshotListener { [self] QuerySnapshot, error in
            guard let snapshot = QuerySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("New comment: \(diff.document.data())")
                }
                if (diff.type == .modified) {
                    print("Modified comment: \(diff.document.data())")
                }
                if (diff.type == .removed) {
                    print("Removed comment: \(diff.document.data())")
                }
            }
            updateComments(snapshot: snapshot)
        }
    }
    
    private func updateComments(snapshot: QuerySnapshot) {
        let comments: [Comment] = snapshot.documents.compactMap { document in
            do {
                var comment = try document.data(as: Comment.self)
                comment.docId = document.documentID
                return comment
            } catch {
                print(error)
            }
            return nil
        }
        self.comments = comments.sorted {
            $0.date > $1.date
        }
    }
    
    func fetch() {
        guard listener == nil else { return }
        dbCollection.getDocuments { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            updateComments(snapshot: snapshot)
        }
    }
    
    func addComment(date: Date, body: String, author: String?, username: String?, photoURL: URL?) {
        let docRef = dbCollection.document()
        let comment = Comment(id: UUID().uuidString, date: date, body: body, author: author, username: username)
        do {
            try docRef.setData(from: comment)
            fetch()
        } catch {
            print("Error adding comment: \(error.localizedDescription)")
        }
    }
    
    func deleteComment(docId: String) async {
        do {
          try await dbCollection.document("\(docId)").delete()
          print("Document successfully removed!")
        } catch {
          print("Error removing document: \(error)")
        }
    }
    
    func updateCommentLikes(commentId: String) {
        if let commentIndex = comments.firstIndex(where: {
            $0.id == commentId
        }) {
            let comment = comments[commentIndex]
            var likes = comment.likes
            
            // 좋아요 이미 눌렀는지 확인
            let isLiked = comment.isLiked
            if isLiked {
                likes -= 1
            } else {
                likes += 1
            }
            comments[commentIndex].likes = likes
            comments[commentIndex].isLiked = !isLiked
            
            dbCollection.document(commentId).updateData(["likes": likes])
        }
    }
}
