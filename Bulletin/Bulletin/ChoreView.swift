//
//  ChoreView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct ChoreView: View {
    @ObservedObject var model: BulletinModel
    let chore: Chore
    
    var body: some View {
        Text(chore.name)
    }
}

struct ChoreView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()

        var body: some View {
            ChoreView(model: model,
                      chore: Chore(name: "Trash"))
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
