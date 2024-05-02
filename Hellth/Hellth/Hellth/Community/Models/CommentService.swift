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
}
