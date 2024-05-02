//
//  ProfileView.swift
//  Hellth
//
//  Created by mini on 5/1/24.
//

import SwiftUI
struct Profile {
    var username: String
    let weight: Int
}
extension Profile {
    func editWeight(weight: Int) -> Void {
        print("weight: \(weight)")
    }
}

struct ProfileView: View {
    var profile = Profile(username: "Jhon", weight: 50)
    @State var usernameInTextField: String
    @State var weightInTextField: String
    @State private var showAlert = false
    
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
                title: Text("are you sure?"),
                message: Text("really?"),
                dismissButton: .default(Text("sure"))
            )
        }
    }
}

#Preview {
    ProfileView(usernameInTextField: "Jhon", weightInTextField: "\(55)")
}
