import SwiftUI

struct FoodRow: View {
    var food: Food
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "fish")
                .foregroundColor(.blue)
            Spacer()
            Text(food.name)
            Spacer()
            Text("\(food.calories) Cal")
        }
        .padding()
    }
}

#Preview {
    let sampleFood = Food(name: "Apple", calories: 52, carbohydrates: 14, protein: 0, fat: 0)
    return FoodRow(food: sampleFood)
}
