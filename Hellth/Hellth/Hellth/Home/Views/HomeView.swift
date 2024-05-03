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
                            //                                .onChange(of: totalCalories) { newValue in
                            //                                    if newValue < calorieInTakeManager.consumedCalories {
                            //                                        totalCalories = calorieInTakeManager.consumedCalories
                            //                                    }
                            //                                }
                        })
                        
                        Button(action: {
                            //                            calorieInTake.remianingCalories
                        }) {
                            Text("Calorie Reset")
                                .foregroundStyle(.red)
                                .customStyled()
                        }
                    }
                    
                    .padding()
                    
                    HStack(spacing: 20){
                        CalorieNutrientView(calorieNutrient: CalorieNutrients(name: "Carbon", value: "50g", measurement: 2), image: "pills")
                        CalorieNutrientView(calorieNutrient: CalorieNutrients(name: "protein", value: "50g", measurement: 2), image: "fish")
                        CalorieNutrientView(calorieNutrient: CalorieNutrients(name: "Fat", value: "50g", measurement: 2), image: "fossil.shell")
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
