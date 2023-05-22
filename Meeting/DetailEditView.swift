//
//  DetailEditView.swift
//  Meeting
//
//  Created by Teff on 2023/05/22.
//

import SwiftUI

struct DetailEditView: View {
    @State private var scrum = DailyScrum.emptyScrum // Initialize the new property with an empty scrum. Declare @State properties as private so that they can be accessed only within the view in which you define them.
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length") // The Text view won’t appear onscreen, but VoiceOver uses it to identify the purpose of the slider
                    }
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in // Add an onDelete modifier to remove attendees from the scrum data
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newAttendeeName.isEmpty) // The button activates when the user starts typing a name in the text field.
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
