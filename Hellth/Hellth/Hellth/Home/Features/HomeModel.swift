import Foundation


struct CalorieInTake {
    var totalCalories: Int
    var consumedCalories: Int = 0
    var remianingCalories: Int {
        return totalCalories - consumedCalories
    }
    mutating func consumeCalories(_ calories: Int) {
        consumedCalories += calories
    }
}


struct CalorieNutrient {
    let name: String
    let value: String
    let measurement: Double
}

struct Food: Identifiable, Codable {
    var id = UUID()
    let name: String
    let calories: Int
    let carbohydrates: Int
    let protein: Int
    let fat: Int
    
}


extension CalorieNutrient {
    static let sampleNutrients: [CalorieNutrient] = [
        CalorieNutrient(name: "Carbon", value: "50g", measurement: 2),
        CalorieNutrient(name: "Protein", value: "50g", measurement: 2),
        CalorieNutrient(name: "Fat", value: "50g", measurement: 2)
    ]
    
}

extension Food {
    static let foods: [Food] = [
        Food(name: "Apple", calories: 52, carbohydrates: 14, protein: 0, fat: 0),
        Food(name: "Banana", calories: 89, carbohydrates: 23, protein: 1, fat: 0),
        Food(name: "Rice", calories: 130, carbohydrates: 28, protein: 3, fat: 0),
        Food(name: "Chicken", calories: 165, carbohydrates: 0, protein: 31, fat: 3)
    ]
}

