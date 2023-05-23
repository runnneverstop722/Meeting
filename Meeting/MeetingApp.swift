//
//  MeetingApp.swift
//  Meeting
//
//  Created by Teff on 2023/05/21.
//

import SwiftUI

@main
struct MeetingApp: App {
    @State private var scrums = DailyScrum.sampleData // initialize the property with sample data
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums) // Pass a binding to scrums to the ScrumsView initializer
            // Set ScrumsView as the initial view for the app. WindowGroup is one of the primitive scenes that SwiftUI provides. In iOS, the views you add to the WindowGroup scene builder are presented in a window that fills the device’s entire screen.
        }
    }
}
