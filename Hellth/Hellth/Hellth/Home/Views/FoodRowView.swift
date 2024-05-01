import SwiftUI

struct FoodRowView: View {
    var food: Food
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "fish")
            Spacer()
            Text(food.name)
            Spacer()
            Text(String(food.calories) + " Cal")
        }
    }
}

#Preview {
    let sampleFood = Food(name: "Apple", calories: 52, carbohydrates: 14, protein: 0, fat: 0)
    return FoodRowView(food: sampleFood)
}
