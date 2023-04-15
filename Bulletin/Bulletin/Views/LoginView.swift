//
//  LoginView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/15/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                switch authorization.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:

                    // Create an account in your system.
                    let userIdentifier = appleIDCredential.user
                    //let fullName = appleIDCredential.fullName
                    //let email = appleIDCredential.email

                    // For the purpose of this demo app, store the `userIdentifier` in the keychain.
                    self.saveUserInKeychain(userIdentifier)

                default:
                    break
                }
            case .failure(let error):
                print("Failed to sign in: \(error.localizedDescription)")
            }
        }
        .signInWithAppleButtonStyle(.black)
        .signInWithAppleButtonStyle(.white)
        .signInWithAppleButtonStyle(.whiteOutline)
        .frame(width: 300, height: 70)
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.rcach.bulletin", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
