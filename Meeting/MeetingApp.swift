//
//  MeetingApp.swift
//  Meeting
//
//  Created by Teff on 2023/05/21.
//

import SwiftUI

@main
struct MeetingApp: App {
    @StateObject private var store = ScrumStore() // The @StateObject property wrapper creates a single instance of an observable object for each instance of the structure that declares it.
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) { // Pass ScrumsView a binding to store.scrums.
                Task { // Add a trailing closure to the ScrumsView initializer, and create an empty Task inside.
                    do { // Add a do-catch block to save the scrum store or halt execution if save() throws an error. Currently, the app terminates if it encounters an error writing to the file system. Need to add more robust error handling in a later tutorial
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do { // Use a do-catch statement to load the saved scrum or halt execution if load() throws an error.
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
