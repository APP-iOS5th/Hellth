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
    @State var usernameInTextField: String
    @State var weightInTextField: String
    @State private var showAlert = false
    @State private var showSheet = false
    var body: some View {
        VStack {
            Section("Profile") {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    VStack {
                        Text(profile.username)
                        Text("\(profile.weight) kg")
                    }
                }
                .padding()
                .frame(height: 200)
            }
            Divider()
            Section("Edit") {
                VStack {
                    HStack {
                        Image(systemName: "arrow.up.and.person.rectangle.portrait")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        VStack {
                            TextField("input", text: $usernameInTextField)
                                .textFieldStyle(.roundedBorder)
                            TextField("input", text: $weightInTextField)
                                .textFieldStyle(.roundedBorder)

                        }
                    }
                }
            }
        }
        
        Button {
            showAlert = true
        } label: {
            Text("Update")
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("display username"),
                message: Text("\(profile.username)"),
                  dismissButton: .default(Text("Confirm"))
                                          )
        }
    }
}

#Preview {
    ProfileView(usernameInTextField: "Jhon", weightInTextField: "\(55)")
}
