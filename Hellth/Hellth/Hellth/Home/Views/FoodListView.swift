import SwiftUI

struct FoodListView: View {
    @State var foods: [Food]
    
    var body: some View {
        ForEach(foods) { food in
            FoodRow(food: food)
        }
        .padding()
    }
}

#Preview {
    let sampleFoods = Food.foods
    return FoodListView(foods: sampleFoods)
}
