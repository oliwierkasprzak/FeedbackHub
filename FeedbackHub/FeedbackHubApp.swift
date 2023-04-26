//
//  FeedbackHubApp.swift
//  FeedbackHub
//
//  Created by Oliwier Kasprzak on 25/04/2023.
//

import SwiftUI

@main
struct FeedbackHubApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SideBarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
