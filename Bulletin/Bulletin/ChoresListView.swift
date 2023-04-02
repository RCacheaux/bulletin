//
//  ChoresListView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI

struct ChoresListView: View {
    @ObservedObject var model: BulletinModel
    
    var body: some View {
        List {
            ForEach(model.chores) { chore in
                ChoreRowView()
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
