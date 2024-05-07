import SwiftUI

struct CalorieNutrientView: View {
    let calorieNutrient: CalorieNutrients
    let image: String
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.largeTitle)
            Text(calorieNutrient.name)
            Text("\(calorieNutrient.value)g")
            Text(String(format: "%.f%%", calorieNutrient.measurement * 100))
        }
        .padding()
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .gray, radius: 3, x: 8, y: 8)
        )
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CalorieNutrientView(calorieNutrient: CalorieNutrients(name: "protein", value: 50, measurement: 0.12), image: "fish")
}
