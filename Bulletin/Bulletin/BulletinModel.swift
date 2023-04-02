//
//  BulletinModel.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/2/23.
//

import SwiftUI

class BulletinModel: ObservableObject {
    @Published var chores: [Chore] = []
    
    init() {
        
    }
}
