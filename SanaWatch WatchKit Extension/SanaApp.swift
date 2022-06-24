//
//  SanaApp.swift
//  SanaWatch WatchKit Extension
//
//  Created by Rustam-Deniz Emirali on 04.03.2022.
//

import SwiftUI

@main
struct SanaApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
