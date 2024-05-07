import SwiftUI

struct HomeView: View {
    @State private var isShowingSheet = false
    @State private var isShowingTotalCalorieSetting = false
    @State var totalCalories: Int = 0
    @ObservedObject var calorieInTakeManager = CalorieInTakeManager()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 25) {
                    Text("Food Record")
                    CalorieCircleView(totalCalories: totalCalories, consumedCalories: calorieInTakeManager.consumedCalories)
                    
                    HStack {
                        Button(action: { isShowingTotalCalorieSetting.toggle() }) {
                            Text("Calorie Setting")
                                .foregroundStyle(.black)
                                .customStyled()
                        }
                        .sheet(isPresented: $isShowingTotalCalorieSetting, content: {
                            TotalCalorieSettingView(totalCaloriesSetting: $totalCalories)
                                .presentationDetents([.medium ])
                                .presentationCornerRadius(23)
                        })
                        
                        Button(action: {
                            calorieInTakeManager.resetCalories()
                        }) {
                            Text("Calorie Reset")
                                .foregroundStyle(.red)
                                .customStyled()
                        }
                    }
                    
                    .padding()
                    
                    HStack(spacing: 20){
                        CalorieNutrientView(calorieNutrient: CalorieNutrients(name: "Carbon", value: 50, measurement: 1), image: "pills")
                        CalorieNutrientView(calorieNutrient: CalorieNutrients(name: "protein", value: 50, measurement: 1), image: "fish")
                        CalorieNutrientView(calorieNutrient: CalorieNutrients(name: "Fat", value: 50, measurement: 1), image: "fossil.shell")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    
                    Text("Food ate")
                        .customStyled()
                    FoodList()
                        .customStyled()
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
                            .tint(.black)
                            .padding()
                            .background(Circle().fill(Color.white).shadow(color: .gray, radius: 3, x: 8, y: 8))
                            .overlay(Circle().stroke(Color.gray))
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
