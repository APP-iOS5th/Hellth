import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class CalorieInTakeManager: ObservableObject {
    @Published var calorieInTake: [CalorieInTake] = []
    @Published var consumedCalories: Int = 0
    private let dbCollection = Firestore.firestore().collection("calorieInTake")
    private var listener: ListenerRegistration?
    
    init(calorieInTake: [CalorieInTake] = []) {
        self.calorieInTake = calorieInTake
        fetchCalorieInTake()
    }
    
    func fetchCalorieInTake() {
        listener = dbCollection.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            self.calorieInTake = documents.compactMap { document in
                do {
                    var calorieInTake = try document.data(as: CalorieInTake.self)
                    calorieInTake.id = document.documentID
                    return calorieInTake
                } catch {
                    print("Error decoding document: \(error)")
                    return nil
                }
            }
            self.consumedCalories = self.calorieInTake.reduce(0) { $0 + $1.consumedCalories }
        }
    }
    
    func addCalorieInTake(calorieInTake: CalorieInTake) {
        do {
            _ = try dbCollection.addDocument(from: calorieInTake)
        } catch {
            print("Error adding document: \(error)")
        }
    }
    
    
    
    func updateTotalCalories(_ totalCalories: Int) {
        for document in calorieInTake {
            guard let documentId = document.id else {
                print("Document ID is nil")
                continue
            }
            
            do {
                try dbCollection.document(documentId).setData(from: CalorieInTake(totalCalories: totalCalories, consumedCalories: consumedCalories), merge: true)
            } catch {
                print("Error updating document: \(error)")
            }
        }
    }
    
    
    
    func resetCalories() {
        for document in calorieInTake {
            guard let documentId = document.id else {
                print("Document ID is nil")
                continue
            }
            
            do {
                try dbCollection.document(documentId).setData(from: CalorieInTake(totalCalories: 0, consumedCalories: 0))
            } catch {
                print("Error updating document: \(error)")
            }
        }
        consumedCalories = 0
    }
}
