import Firebase
import FirebaseFirestore


final class FoodManager: ObservableObject {
    @Published var foods: [Food]
    private let dbCollection = Firestore.firestore().collection("foods")
    private var listener: ListenerRegistration?
    
    init(foods: [Food] = []) {
        self.foods = foods
        startRealtimeUpdates()
    }
    
    func fetch() {
        guard listener == nil else { return }
        dbCollection.getDocuments { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            updateFoods(snapshot: snapshot)
        }
    }
    
    func addFood(name: String, calories: Int, carbohydrates: Int, protein: Int, fat: Int) {
        let food = Food(name: name, calories: calories, carbohydrates: carbohydrates, protein: protein, fat: fat)
        do {
            _ = try dbCollection.addDocument(from: food)
        } catch {
            print("Error adding food document: \(error)")
        }
    }
    
    
    private func startRealtimeUpdates() {
        listener = dbCollection.addSnapshotListener { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            updateFoods(snapshot: snapshot)
        }
    }
    
    private func updateFoods(snapshot: QuerySnapshot) {
        let foods: [Food] = snapshot.documents.compactMap { document in
            guard let foodData = try? document.data(as: Food.self) else {
                return nil
            }
            return foodData
        }
        self.foods = foods
    }
}
