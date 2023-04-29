//
//  MealsTabView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/15/23.
//

import SwiftUI

public struct MealsTabView: View {
    public init() {}
    
    public var body: some View {
        NavigationStack {
            Text("Meals View")
                .navigationTitle("Meals")
        }
    }
}

struct MealsTabView_Previews: PreviewProvider {
    static var previews: some View {
        MealsTabView()
    }
}
