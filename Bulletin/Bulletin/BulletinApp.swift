//
//  BulletinApp.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI
import AuthenticationServices
import Chores


@main
struct BulletinApp: App {
    @StateObject private var model = BulletinModel()
    
    init() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("Logged in...")
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("Not Logged in...")
            default:
                break
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
                .environment(\.managedObjectContext, model.container.viewContext)
        }
    }
}
