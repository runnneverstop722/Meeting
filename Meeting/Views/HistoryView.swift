//
//  HistoryView.swift
//  Meeting
//
//  Created by Taehoon Lee on 2023/05/28.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView { // To ensure that users can view the entire transcription. This view isn’t the first scroll view in your app. The list view automatically embeds itself in a scroll view.
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

extension History { // To display attendees in a human-readable string
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
        // ListFormatter converts the attendees data into a single, comma-separated string.
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(attendees: [
            DailyScrum.Attendee(name: "Harvey"),
            DailyScrum.Attendee(name: "Allison")
        ],
                transcript: "It’s not on the menu, but might I suggest the “I got my ass kicked” martini? It goes well with the “Second-Tier Law Firm” potato skins.")
    }
    static var previews: some View {
        HistoryView(history: history)
    }
}
