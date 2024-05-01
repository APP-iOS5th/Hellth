import SwiftUI

struct CalorieNutrientView: View {
    let calorieNutrient: CalorieNutrient
    let image: String
    
    var body: some View {
        VStack {
            Image(systemName: image)
            Text(calorieNutrient.name)
            Text(calorieNutrient.value)
                .font(.title)
            Text(String(calorieNutrient.measurement) + "%")
        }
        .padding()
        .foregroundStyle(.blue)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(color: .gray, radius: 3, x: 8, y: 8))
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    CalorieNutrientView(calorieNutrient: CalorieNutrient(name: "protein", value: "50g", measurement: 0.12), image: "")
}
