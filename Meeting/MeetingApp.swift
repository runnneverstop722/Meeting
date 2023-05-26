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
    @State private var errorWrapper: ErrorWrapper? // Add an optional state variable named errorWrapper. The default value of an optional is nil. When assigning a value to this state variable, SwiftUI updates the view.
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) { // Pass ScrumsView a binding to store.scrums.
                Task { // Add a trailing closure to the ScrumsView initializer, and create an empty Task inside.
                    do { // Add a do-catch block to save the scrum store or halt execution if save() throws an error. Currently, the app terminates if it encounters an error writing to the file system. Need to add more robust error handling in a later tutorial
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }
                .task {
                    do { // Use a do-catch statement to load the saved scrum or halt execution if load() throws an error.
                        try await store.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "The app will load sample data and continue.")
                    }
                }
                .sheet(item: $errorWrapper) { // Add a sheet with a binding to the error wrapper item. The modal sheet provides a closure to execute code when the user dismisses the modal sheet, and a closure to supply a view to present modally.
                    store.scrums = DailyScrum.sampleData // In the onDismiss closure, assign sample data to the scrums array. Load sample data when the user dismisses the modal. Because we provide a binding to the condition that initiates the presentation, SwiftUI resets the optional error wrapper to nil when the user dismisses the presentation.
                } content: { wrapper in
                    ErrorView(errorWrapper: wrapper) // Create an ErrorView that passes in the errorWrapper. The ErrorView displays when an error occurs.
                }
        }
    }
}
