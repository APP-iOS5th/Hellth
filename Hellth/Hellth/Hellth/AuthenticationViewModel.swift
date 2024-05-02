////
////  AuthenticationViewModel.swift
////  Hellth
////
////  Created by 박지혜 on 5/2/24.
////
//
//import Foundation
//import FirebaseAuth
//import GoogleSignIn
//import FirebaseCore
//
//extension UIApplication {
//    static var currentRootViewController: UIViewController? {
//        UIApplication.shared.connectedScenes
//            .filter({
//                $0.activationState == .foregroundActive
//            })
//            .map({
//                $0 as? UIWindowScene
//            })
//            .compactMap({
//                $0
//            })
//            .first?.windows
//            .filter({
//                $0.isKeyWindow
//            })
//            .first?
//            .rootViewController
//    }
//}
//
//// 인증 모델
//@Observable
//final class AuthenticationViewModel {
//    enum State {
//        case busy
//        case signedIn
//        case signedOut
//    }
//    
//    var state: State = .busy
//    private var authResult: AuthDataResult? = nil
//    var username: String {
//        authResult?.user.displayName ?? ""
//    }
//    var email: String {
//        authResult?.user.email ?? ""
//    }
//    var photoURL: URL? {
//        authResult?.user.photoURL
//    }
//    
//    // 구글 로그아웃 및 연결 해제, 파이어베이스 로그아웃
//    func logout() {
//        GIDSignIn.sharedInstance.signOut()
//        GIDSignIn.sharedInstance.disconnect()
//        try? Auth.auth().signOut()
//        authResult = nil
//        state = .signedOut
//    }
//    
//    // 이전에 저장된 구글 로그인 정보 가져오기
//    func restorePreviousSignIn() {
//        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//            if let error {
//                print("Error: \(error.localizedDescription)")
//            }
//            Task {
//                await self.signIn(user: user)
//            }
//        }
//    }
//    
//    // 구글 로그인
//    func login() {
//        state = .busy
//        guard let clientID = FirebaseApp.app()?options.clientID,
//              let rootViewController = UIApplication.currentRootViewController else {
//            return
//        }
//        let configuration = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = configuration
//        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController, hint: nil) { result, error in
//            if let error { 
//                print("Error: \(error.localizedDescription)")
//            }
//            Task {
//                await self.signIn(user: result?.user)
//            }
//        }
//    }
//    
//    // firebase 로그인
//    private func signIn(user: GIDGoogleUser?) async {
//        guard let user, let idToken = user.idToken else {
//            state = .signedOut
//            return
//        }
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
//                                                       accessToken: user.accessToken.tokenString)
//        
//        do {
//            authResult = try await Auth.auth().signIn(with: credential)
//            state = .signedIn
//        } catch {
//            state = .signedOut
//            print("Error: \(error.localizedDescription)")
//        }
//    }
//}
//
