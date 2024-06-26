//
//  PostsService.swift
//  Hellth
//
//  Created by 박지혜 on 5/2/24.
//

import Firebase
import FirebaseFirestore

class PostsService: ObservableObject {
    @Published var posts: [Post]
    private let dbCollection = Firestore.firestore().collection("posts")
    private var listener: ListenerRegistration?
    
    
    init(posts: [Post] = []) {
        self.posts = posts
        startRealtimeUpdates()
    }
    
    // 실시간 업데이트
    private func startRealtimeUpdates() {
        listener = dbCollection.addSnapshotListener{ [self] QuerySnapshot, error in
            guard let snapshot = QuerySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("New post: \(diff.document.data())")
                }
                if (diff.type == .modified) {
                    print("Modified post: \(diff.document.data())")
                }
                if (diff.type == .removed) {
                    print("Removed post: \(diff.document.data())")
                }
            }
            updatePosts(snapshot: snapshot)
        }
    }
    
    // Post 구조체에 데이터 넣기
    private func updatePosts(snapshot: QuerySnapshot) {
        let posts: [Post] = snapshot.documents.compactMap { document in
            var post = try? document.data(as: Post.self)
            post?.docId = document.documentID
            return post
        }
        self.posts = posts.sorted {
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
            updatePosts(snapshot: snapshot)
        }
    }
    
    func addPost(category: String, title: String, date: Date, body: String, author: String?, username: String?, photoURL: URL?) {
        print("Author: \(String(describing: author))")
        
        let post = Post(id: UUID().uuidString, category: category, title: title, date: date, body: body, author: author, username: username)
        _ = try? dbCollection.addDocument(from: post)
        fetch()
    }
    
    func deletePost(postId: String) async {
        do {
            let postRef = dbCollection.document(postId)
            let commentsCollection = try await postRef.collection("comments").getDocuments()
            
            for document in commentsCollection.documents {
                try await document.reference.delete()
            }
            
            try await postRef.delete()
            print("Document successfully removed!")
        } catch {
              print("Error removing document: \(error)")
        }
    }
}
