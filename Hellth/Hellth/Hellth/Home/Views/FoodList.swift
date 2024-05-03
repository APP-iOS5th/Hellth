import SwiftUI

struct FoodList: View {
    @ObservedObject var foodManager = FoodManager()
    
    var body: some View {
        VStack {
            ForEach(foodManager.foods) { food in
                FoodRow(food: food)
            }
        }
        .onAppear {
            foodManager.fetch()
        }
    }
}

#Preview {
    FoodList()
}
