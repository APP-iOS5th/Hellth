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


