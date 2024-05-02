//
//  ProfileView.swift
//  Hellth
//
//  Created by mini on 5/1/24.
//

import SwiftUI
struct Profile {
    let username: String
    let weight: Int
}
extension Profile {
    func editWeight(weight: Int) -> Int {
        return weight
    }
}

struct ProfileView: View {
    let profile = Profile(username: "Jhon", weight: 50)
    @State var weightInTextField: String
    @State private var showAlert = false
    @State private var showSheet = false
    var body: some View {
        
        Button {
            showAlert = true
        } label: {
            Text("Alert")
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("display username"),
                message: Text("\(profile.username)"),
                  dismissButton: .default(Text("Confirm"))
                                          )
        }
        Button {
            showSheet = true
        } label: {
            Text("Sheet")
        }
        .sheet(isPresented: $showSheet) {
            TextField("input", text: $weightInTextField)
                .textFieldStyle(.roundedBorder)
        }
        


        Text(profile.username)
        Image(systemName: "person.circle.fill")
    }
}

#Preview {
    ProfileView(weightInTextField: "\(55)")
}
