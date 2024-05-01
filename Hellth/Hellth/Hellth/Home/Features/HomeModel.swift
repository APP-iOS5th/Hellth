import Foundation

struct Food: Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
    let carbohydrates: Int
    let protein: Int
    let fat: Int
}


struct CalorieNutrient {
    let name: String
    let value: String
    let measurement: Double
}
