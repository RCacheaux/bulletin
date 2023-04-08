//
//  ChoresListView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI

struct ChoresListView: View {
    @ObservedObject var model: BulletinModel
    @FetchRequest(sortDescriptors: []) var chores: FetchedResults<CDChore>
    
    var body: some View {
        List {
            ForEach(chores) { cdchore in
                let chore = Chore(name: cdchore.name!)
                NavigationLink {
                    ChoreView(model: model, chore: chore)
                } label: {
                    ChoreRowView(chore: chore)
                }
            }
        }
    }
}

struct ChoresListView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()

        var body: some View {
            ChoresListView(model: model)
        }
    }
    
    static var previews: some View {
        NavigationStack {
            Preview()
        }
    }
}
