import SwiftUI


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


extension Color  {
   static let randomColors: [Color] = [ .red, .orange, .yellow, .green, .blue, .purple, .pink, .teal, .brown, .gray, .black, .white, .mint, .indigo]
}
