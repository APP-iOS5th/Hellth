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
                    let calorieInTake = try document.data(as: CalorieInTake.self)
                    return calorieInTake
                } catch {
                    print("Error decoding document: \(error)")
                    return nil
                }
            }
        }
    }
    
    func addCalorieInTake(calorieInTake: CalorieInTake) {
        do {
            _ = try dbCollection.addDocument(from: calorieInTake)
        } catch {
            print("Error adding document: \(error)")
        }
    }
}
