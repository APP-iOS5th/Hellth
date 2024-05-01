import SwiftUI

struct HomeView: View {
    @State private var foods: [Food] = [
        Food(name: "Apple", calories: 52, carbohydrates: 14, protein: 0, fat: 0),
        Food(name: "Banana", calories: 89, carbohydrates: 23, protein: 1, fat: 0),
        Food(name: "Rice", calories: 130, carbohydrates: 28, protein: 3, fat: 0),
        Food(name: "Chicken", calories: 165, carbohydrates: 0, protein: 31, fat: 3)
    ]
    @State private var isShowingSheet = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Food Record")
                    CalorieCircleView()
                    
                    VStack(spacing: 20) {
                        
                        Button(action: { print("Reset Button") }) {
                            Text("Reset")
                        }
                    }
                    .padding()
                    HStack(spacing: 20){
                        CalorieNutrientView(calorieNutrient: CalorieNutrient(name: "Carbon", value: "50g", measurement: 2), image: "pills")
                        CalorieNutrientView(calorieNutrient: CalorieNutrient(name: "protein", value: "50g", measurement: 2), image: "fish")
                        CalorieNutrientView(calorieNutrient: CalorieNutrient(name: "Fat", value: "50g", measurement: 2), image: "fossil.shell")
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    Text("Food ate")
                        .padding()
                    
                    ForEach(foods) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Button(action: { print("Remove Button") }) {
                                Text("Remove")
                            }
                        }
                        .padding()
                    }
                }
                .padding()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { isShowingSheet.toggle() }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .tint(.green)
                            .padding()
                            .background(Circle().fill(Color.white).shadow(color: .gray, radius: 3, x: 8, y: 8))
                            .overlay(
                                Circle().stroke(Color.green)
                            )
                    }
                    .sheet(isPresented: $isShowingSheet, content: {
                        AddCalorieView()
                    })
                }
                .padding()
            }
        }
    }
}




#Preview {
    HomeView()
}
