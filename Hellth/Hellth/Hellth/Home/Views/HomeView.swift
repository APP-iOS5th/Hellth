import SwiftUI

struct HomeView: View {
    
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
                                .foregroundStyle(.red)
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
                    FoodListView(foods: Food.foods)
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
