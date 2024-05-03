import SwiftUI

struct TotalCalorieSettingView: View {
    @Binding var totalCaloriesSetting: Int
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Total Calories", value: $totalCaloriesSetting , formatter: NumberFormatter())
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Total Calorie Setting")
            .navigationBarItems(trailing:
                                    Button("Done") {
                print("Total Calories Setting: \(totalCaloriesSetting)")
            }
            )
        }
        .cornerRadius(16)
    }
}
#Preview {
    TotalCalorieSettingView(totalCaloriesSetting: .constant(0))
}
