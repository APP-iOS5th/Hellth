import SwiftUI

struct CalorieCircleView: View {
    var totalCalories: Int = 1000
    var consumedCalories: Int = 800
    var remainingCalories: Int {
        return totalCalories - consumedCalories
    }
    var body: some View {
        let progress = Double(consumedCalories) / Double(totalCalories)
        let randomColors: [Color] = [ .red, .orange, .yellow, .green, .blue, .purple, .pink, .teal, .brown, .gray, .black, .white, .mint, .indigo]
        
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2),lineWidth: 20)
                .fill(Color.white)
                .shadow(color: .gray, radius: 3, x: 4, y: 4)
                .overlay(
                    VStack {
                        Spacer()
                        Text("total: \(totalCalories) cal")
                        Spacer()
                        Text("Current Calorie: \(consumedCalories)")
                        Spacer()
                        Text("Remain Calorie: \(remainingCalories)")
                        Spacer()}
                )
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(AngularGradient(gradient: Gradient(colors:randomColors.shuffled()), center: .center), lineWidth: 10)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.0), value: progress)
                .shadow(color: .gray, radius: 3, x: 8, y: 8)
        }
        .padding()
    }
}

#Preview {
    CalorieCircleView()
}
