//
//  ProfileView.swift
//  Hellth
//
//  Created by mini on 5/1/24.
//

import SwiftUI

struct ProfileView: View {
    let username = "Jhon"
    @State private var showAlert = false
    var body: some View {
        Button {
            showAlert = true
        } label: {
            Text("Edit")
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Edit username"),
            message: Text("\(username)"),
                  dismissButton: .default(Text("Confirm"))
                                          )
        }

        Text(username)
        Image(systemName: "person.circle.fill")
    }
}

#Preview {
    ProfileView()
}
