import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


enum Nutrient {
    case carbohydrates
    case protein
    case fat
}


struct CalorieInTake: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var totalCalories: Int
    var consumedCalories: Int
    var remianingCalories: Int {
        return totalCalories - consumedCalories
    }
    mutating func consumeCalories(_ calories: Int) {
        consumedCalories += calories
    }
}


struct CalorieNutrients: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let name: String
    let value: Int
    let measurement: Double
    
    init(name: String, value: Int, measurement: Double) {
        self.name = name
        self.value = value
        self.measurement = measurement
    }
}

struct Food: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let name: String
    let calories: Int
    let carbohydrates: Int
    let protein: Int
    let fat: Int
    let createdAt: Date
    
    init(name: String, calories: Int, carbohydrates: Int, protein: Int, fat: Int) {
        self.name = name
        self.calories = calories
        self.carbohydrates = carbohydrates
        self.protein = protein
        self.fat = fat
        self.createdAt = Date()
    }
    
    
    func totalCalories() -> Int {
        return calories + (carbohydrates * 4) + (protein * 4) + (fat * 9)
    }
    
    
    func nutrientPercentage(nutrient: Nutrient) -> Double {
        let totalCal = totalCalories()
        switch nutrient {
        case .carbohydrates:
            return Double(carbohydrates * 4) / Double(totalCal) * 100
        case .protein:
            return Double(protein * 4) / Double(totalCal) * 100
        case .fat:
            return Double(fat * 9) / Double(totalCal) * 100
        }
    }
}

extension CalorieNutrients {
    static let sampleNutrients: [CalorieNutrients] = [
        CalorieNutrients(name: "Carbon", value: 50, measurement: 2),
        CalorieNutrients(name: "Protein", value: 50, measurement: 2),
        CalorieNutrients(name: "Fat", value: 50, measurement: 2)
    ]
    
}
