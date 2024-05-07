import SwiftUI

struct TotalCalorieSettingView: View {
    @Binding var totalCaloriesSetting: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var temporaryTotalCalories: String = ""
    @StateObject var calorieInTakeManager = CalorieInTakeManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Total Calories", text: $temporaryTotalCalories)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Total Calorie Setting")
            .navigationBarItems(trailing:
                                    Button("Done") {
                if let calories = Int(temporaryTotalCalories) {
                    totalCaloriesSetting = calories
                    print("Total Calories Setting: \(totalCaloriesSetting)")
                    calorieInTakeManager.updateTotalCalories(calories)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            )
        }
        .cornerRadius(16)
    }
}
#Preview {
    TotalCalorieSettingView(totalCaloriesSetting: .constant(0))
}
