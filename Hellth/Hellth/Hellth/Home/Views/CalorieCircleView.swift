import SwiftUI

struct CalorieCircleView: View {
    var totalCalories: Int
    var consumedCalories: Int
    var remainingCalories: Int {
        return totalCalories - consumedCalories
    }
    var body: some View {
        let progress = Double(consumedCalories) / Double(totalCalories)
        
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
                        Text("Consumed: \(consumedCalories)")
                        Spacer()
                        Text("Remaining: \(remainingCalories)")
                        Spacer()}
                )
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(AngularGradient(gradient: Gradient(colors:Color.randomColors.shuffled()), center: .center), lineWidth: 10)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.0), value: progress)
                .shadow(color: .gray, radius: 3, x: 8, y: 8)
        }
        .padding()
    }
}

#Preview {
    CalorieCircleView(totalCalories: 10, consumedCalories: 3)
}
