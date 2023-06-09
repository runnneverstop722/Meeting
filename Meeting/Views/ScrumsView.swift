//
//  ScrumsView.swift
//  Meeting
//
//  Created by Teff on 2023/05/22.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase // Observe this value and save user data when it becomes inactive.
    @State private var isPresentingNewScrumView = false
    let saveAction: ()->Void // Add a saveAction property, and pass an empty action in the preview.
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                List($scrums) { $scrum in // The List view passes a scrum into its closure, but the DetailView initializer expects a binding to a scrum. You’ll use array binding syntax to retrieve a binding to an individual scrum. To use array binding syntax in SwiftUI, you’ll pass a binding to an array into a List. To complete the syntax, pass a binding($scrum) to each iteration of the loop’s closure.
                    NavigationLink(destination: DetailView(scrum: $scrum)) {
                        CardView(scrum: scrum)
                            .listRowBackground(scrum.theme.mainColor)
                    }
                    .listRowBackground(scrum.theme.mainColor)
                }
                .navigationTitle("Daily Scrums")
                .toolbar {
                    Button {
                        isPresentingNewScrumView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Scrum")
                }
            }
            .sheet(isPresented: $isPresentingNewScrumView) {
                NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
            }
            .onChange(of: scenePhase) { phase in // Add an onChange modifier observing the scenePhase value. Use onChange(of:perform:) to trigger actions when a specified value changes.
                if phase == .inactive { saveAction() } // Call saveAction() if the scene is moving to the inactive phase. A scene in the inactive phase no longer receives events and may be unavailable to the user.
            }
        } else {
            NavigationView {
                List($scrums) { $scrum in // The List view passes a scrum into its closure, but the DetailView initializer expects a binding to a scrum. You’ll use array binding syntax to retrieve a binding to an individual scrum. To use array binding syntax in SwiftUI, you’ll pass a binding to an array into a List. To complete the syntax, pass a binding($scrum) to each iteration of the loop’s closure.
                    NavigationLink(destination: DetailView(scrum: $scrum)) {
                        CardView(scrum: scrum)
                            .listRowBackground(scrum.theme.mainColor)
                    }
                    .listRowBackground(scrum.theme.mainColor)
                }
                .navigationTitle("Daily Scrums")
                .toolbar {
                    Button {
                        isPresentingNewScrumView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Scrum")
                }
            }
            .sheet(isPresented: $isPresentingNewScrumView) {
                NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
            }
            .onChange(of: scenePhase) { phase in // Add an onChange modifier observing the scenePhase value. Use onChange(of:perform:) to trigger actions when a specified value changes.
                if phase == .inactive { saveAction() } // Call saveAction() if the scene is moving to the inactive phase. A scene in the inactive phase no longer receives events and may be unavailable to the user.
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {}) // Will provide the saveAction closure when instantiating ScrumsView.
    }
}
