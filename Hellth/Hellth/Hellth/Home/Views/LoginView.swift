//
//import SwiftUI
//import AuthenticationServices
//
//
//struct LoginView: View {
//    @State private var userName: String = ""
//    @State private var userEmail: String = ""
//
//    
//    @AppStorage("storedName") private var storedName: String = "" {
//        didSet {
//            userName = storedName
//        }
//    }
//    
//    @AppStorage("storedEmail") private var storedEmail: String = "" {
//        didSet {
//            userEmail = storedEmail
//        }
//    }
//    
//    @AppStorage("userID") private var userID: String = ""
//    
//    
//    //view
//    
//    var body: some View {
//        ZStack {
//      
//            Color.white
//            if userName.isEmpty {
//                SignInWithAppleButton(.signIn,
//                                      onRequest: onRequest,
//                                      onCompletion: onCompletion)
//                .signInWithAppleButtonStyle(.black)
//                .frame(width: 200, height: 50)
//               
//            } else {
//                Text("Welcome\n\(userName), \(userEmail)")
//                    .foregroundStyle(.black)
//                    .font(.headline)
//            }
//        }
//        .task { await authorize() }
//        .background(.white)
//        
//    }
//    
//    
//
//    private func authorize() async {
//        guard !userID.isEmpty else {
//            userName = ""
//            userEmail = ""
//            return
//        }
//        guard let credentialState = try? await ASAuthorizationAppleIDProvider()
//            .credentialState(forUserID: userID) else {
//            userName = ""
//            userEmail = ""
//            return
//        }
//        
//        switch credentialState {
//        case .authorized:
//            userName = storedName
//            userEmail = storedEmail
//        default:
//            userName = ""
//            userEmail = ""
//        }
//    }
//    
//    private func onRequest(_ request: ASAuthorizationAppleIDRequest) {
//        request.requestedScopes = [.fullName, .email]
//    }
//    
//    private func onCompletion(_ result: Result<ASAuthorization, Error>) {
//        switch result {
//        case .success(let authResult):
//            guard let credential = authResult.credential as? ASAuthorizationAppleIDCredential
//            else { return }
//            storedName = credential.fullName?.givenName ?? ""
//            storedEmail = credential.email ?? ""
//            userID = credential.user
//        case .failure(let error):
//            print("Authorization failed: " + error.localizedDescription)
//        }
//    }
//}
//#Preview {
//    LoginView()
//}

import AuthenticationServices
import GoogleSignInSwift
import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()
                Image("loginScreen")
                    .foregroundStyle(Color(.loginBlue))
                    .padding()
                Spacer()

                // MARK: - Apple
                SignInWithAppleButton(
                    onRequest: { request in
                        AppleSignInManager.shared.requestAppleAuthorization(request)
                    },
                    onCompletion: { result in
                        handleAppleID(result)
                    }
                )
                .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
                .frame(width: 280, height: 45, alignment: .center)

                // MARK: - Google
                GoogleSignInButton {
                    Task {
                        await signInWithGoogle()
                    }
                }
                .frame(width: 280, height: 45, alignment: .center)

                // MARK: - Anonymous
                // Hide `Skip` button if user is anonymous.
                if authManager.authState == .signedOut {
                    Button {
                        signAnonymously()
                    } label: {
                        Text("Skip")
                            .font(.body.bold())
                            .frame(width: 280, height: 45, alignment: .center)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.loginYellow))
        }
    }

    /// Sign in with `Google`, and authenticate with `Firebase`.
    func signInWithGoogle() async {
        do {
            guard let user = try await GoogleSignInManager.shared.signInWithGoogle() else { return }

            let result = try await authManager.googleAuth(user)
            if let result = result {
                print("GoogleSignInSuccess: \(result.user.uid)")
                dismiss()
            }
        }
        catch {
            print("GoogleSignInError: failed to sign in with Google, \(error))")
            // Here you can show error message to user.
            return
        }
    }

    func handleAppleID(_ result: Result<ASAuthorization, Error>) {
        if case let .success(auth) = result {
            guard let appleIDCredentials = auth.credential as? ASAuthorizationAppleIDCredential else {
                print("AppleAuthorization failed: AppleID credential not available")
                return
            }

            Task {
                do {
                    let result = try await authManager.appleAuth(
                        appleIDCredentials,
                        nonce: AppleSignInManager.nonce
                    )
                    if let result = result {
                        dismiss()
                    }
                } catch {
                    print("AppleAuthorization failed: \(error)")
                    // Here you can show error message to user.
                }
            }
        }
        else if case let .failure(error) = result {
            print("AppleAuthorization failed: \(error)")
            // Here you can show error message to user.
        }
    }

    /// Sign-in anonymously
    func signAnonymously() {
        Task {
            do {
                let result = try await authManager.signInAnonymously()
                print("SignInAnonymouslySuccess: \(result?.user.uid ?? "N/A")")
            }
            catch {
                print("SignInAnonymouslyError: \(error)")
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}
