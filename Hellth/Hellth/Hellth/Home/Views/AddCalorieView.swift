import SwiftUI

struct AddCalorieView: View {
    @State private var isPresented = false
    @State private var newFoodName = ""
    @State private var newFoodCalories = ""
    @State private var newFoodCarbohydrates = ""
    @State private var newFoodProtein = ""
    @State private var newFoodFat = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Section {
                Text("Food Name")
                TextField("Food Name", text: $newFoodName)
                TextField("Calories", text: $newFoodCalories)
                    .keyboardType(.numberPad)
            }
            
            Section {
                Text("Calorie Nutrient")
                TextField("Carbohydrates", text: $newFoodCarbohydrates)
                    .keyboardType(.numberPad)
                TextField("Protein", text: $newFoodProtein)
                    .keyboardType(.numberPad)
                TextField("Fat", text: $newFoodFat)
                    .keyboardType(.numberPad)
            }
            .padding()
            
            Button(action: {
                print("Done Button")
                isPresented = false
            }) {
                Text("Done")
            }
            .padding()
        }
    }
}

#Preview {
    AddCalorieView()
}
