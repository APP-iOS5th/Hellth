import SwiftUI

struct CalorieCircleView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2),lineWidth: 20)
                .overlay(
                    VStack {
                        Spacer()
                        Text("Goal: 1000")
                        Spacer()
                        Text("Current Calorie: 300")
                        Spacer()
                        Text("Remain Calorie: 700")
                        Spacer()}
                )
            Circle()
                .stroke()
            
        }
        .padding()
    }
}

#Preview {
    CalorieCircleView()
}
