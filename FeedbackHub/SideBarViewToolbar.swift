//
//  SideBarViewToolbar.swift
//  FeedbackHub
//
//  Created by Oliwier Kasprzak on 24/05/2023.
//

import SwiftUI

struct SideBarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingAwards = false
    var body: some View {
        #if DEBUG
        Button {
            dataController.removeAll()
            dataController.sampleData()
        } label: {
            Label("Add samples", systemImage: "flame")
        }
        #endif
        Button(action: dataController.addTag) {
            Label("Add tag", systemImage: "plus")
        }

        Button {
            showingAwards.toggle()
        } label: {
            Label("Awards", systemImage: "rosette")
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init)
    }
}

struct SideBarViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        SideBarViewToolbar()
    }
}
