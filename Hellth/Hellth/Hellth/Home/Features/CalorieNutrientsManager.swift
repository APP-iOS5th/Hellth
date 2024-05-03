import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class CalorieNutrientsManager: ObservableObject {
    @Published var calorieNutrients: [CalorieNutrients] = []
    private let dbCollection = Firestore.firestore().collection("calorieNutrients")
    private var listener: ListenerRegistration?
    
    init(calorieNutrients: [CalorieNutrients] = []) {
        self.calorieNutrients = calorieNutrients
        fetchCalorieNutrients()
    }
    
    func fetchCalorieNutrients() {
        listener = dbCollection.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            self.calorieNutrients = documents.compactMap { document in
                do {
                    let calorieNutrient = try document.data(as: CalorieNutrients.self)
                    return calorieNutrient
                } catch {
                    print("Error decoding document: \(error)")
                    return nil
                }
            }
        }
    }
    
    func addCalorieNutrient(calorieNutrient: CalorieNutrients) {
        do {
            _ = try dbCollection.addDocument(from: calorieNutrient)
        } catch {
            print("Error adding document: \(error)")
        }
    }
}
