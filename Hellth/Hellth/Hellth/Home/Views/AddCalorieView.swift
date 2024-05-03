import SwiftUI

struct AddCalorieView: View {
    @State private var foodName = ""
    @State private var foodCalories = ""
    @State private var foodCarbohydrates = ""
    @State private var foodProtein = ""
    @State private var foodFat = ""
    @State private var imageName: String?
    
    @StateObject private var foodManager = FoodManager()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Information")) {
                    TextField("Food Name", text: $foodName)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.bottom, 8)
                    
                    /// Image upload section
                    
                    HStack {
                        TextField("Calories", text: $foodCalories)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(8)
                        
                        Text("cal")
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                
                Section(header: Text("Calorie Nutrient")) {
                    nutrientTextField("Carbohydrates", text: $foodCarbohydrates, unit: "g")
                    nutrientTextField("Protein", text: $foodProtein, unit: "g")
                    nutrientTextField("Fat", text: $foodFat, unit: "g")
                }
            }
            .navigationTitle("Add Food")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        foodManager.addFood(
                            name: foodName,
                            calories: Int(foodCalories) ?? 0,
                            carbohydrates: Int(foodCarbohydrates) ?? 0,
                            protein: Int(foodProtein) ?? 0,
                            fat: Int(foodFat) ?? 0
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    AddCalorieView()
}
