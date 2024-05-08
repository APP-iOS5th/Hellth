//
//  FastingManager.swift
//  Hellth
//
//  Created by Jungjin Park on 2024-05-08.
//

import Foundation
import FirebaseFirestore

final class FastingManager: ObservableObject {
    @Published var fastings: [Fasting]
    
    private let dbCollection = Firestore.firestore().collection("fastings")
    
    private var listener: ListenerRegistration?
    
    init(fastings: [Fasting] = []) {
        self.fastings = fastings
        startRealtimeUpdate()
    }
    
    func fetch() {
        guard listener == nil else { return }
        dbCollection.getDocuments { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot: \(error!)")
                return
            }
            updateFasting(snapshot: snapshot)
        }
    }
    
    func addFasting(remainingSeconds: Double,  durationSeconds: Int,  passedSeconds: Int, isFasting: Bool, startDateTime: Date, durationHour: Int) {
        let fasting = Fasting(remainingSeconds: remainingSeconds,  durationSeconds: durationSeconds,  passedSeconds: passedSeconds, isFasting: isFasting, startDateTime: startDateTime, durationHour: durationHour)
        _ = try? dbCollection.addDocument(from: fasting)
        fetch()
    }
    
    private func startRealtimeUpdate() {
        listener = dbCollection.addSnapshotListener { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot: \(error!)")
                return
            }
            updateFasting(snapshot: snapshot)
        }
    }
    
    private func updateFasting(snapshot: QuerySnapshot) {
        let fastings: [Fasting] = snapshot.documents.compactMap { document in
            try? document.data(as: Fasting.self)
        }
        self.fastings = fastings.sorted {
            $0.startDateTime > $1.startDateTime
        }
    }
}
