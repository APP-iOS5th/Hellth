import SwiftUI

struct HomeView: View {
    @State private var food = [
        Food(name: "apple"),
        Food(name: "banana"),
        Food(name: "rice"),
        Food(name: "chicken")
    ]
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Food Record")
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2),lineWidth: 20)
                        
                        VStack {
                            Spacer()
                            Text("Goal: 1000")
                            Spacer()
                            Text("Current Calorie: 300")
                            Spacer()
                            Text("Remain Calorie: 700")
                            Spacer()
                        }
                        Circle()
                            .stroke()
                        
                    }
                    .padding()
                    
                    VStack(spacing: 20) {
                        
                        Button(action: { print("Reset Button") }) {
                            Text("Reset")
                        }
                    }
                    .padding()
                    HStack(spacing: 20){
                        Ingredient(image: "rectangle", ingredient: "Carbon", value: "45", measurement: "%")
                        Ingredient(image: "triangle", ingredient: "Protein", value: "24", measurement: "%")
                        Ingredient(image: "circle", ingredient: "Fat", value: "35", measurement: "%")
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    Text("Eating food")
                        .padding()
                    
                    ForEach(food) { item in
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
                    Button(action: { print("Add Button") }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .tint(.green)
                            .padding()
                            .background(Circle().fill(Color.white).shadow(color: .gray, radius: 3, x: 8, y: 8))
                            .overlay(
                                Circle().stroke(Color.green)
                            )
                    }
                }
                .padding()
            }
            
        }
        
    }
}


struct Ingredient: View {
    let image: String
    let ingredient: String
    let value: String
    let measurement: String
    
    var body: some View {
        VStack {
            Image(systemName: image)
            Text(ingredient)
            Text(value)
                .font(.title)
            Text(measurement)
        }
        .padding()
        .foregroundStyle(.red)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(color: .gray, radius: 3, x: 8, y: 8))
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}
