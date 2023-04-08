//
//  BulletinApp.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI

@main
struct BulletinApp: App {
    @StateObject private var model = BulletinModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
                .environment(\.managedObjectContext, model.container.viewContext)
        }
    }
}
