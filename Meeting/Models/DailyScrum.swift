//
//  DailyScrum.swift
//  Meeting
//
//  Created by Teff on 2023/05/21.
//

import Foundation

struct DailyScrum: Identifiable {
    var id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var lengthInMinutesAsDouble: Double { //  Add a double-precision representation of the scrum’s length that you’ll bind to a slider
        get { // Provide a getter that returns the length of a scrum meeting as a double value. For Swift functions that return a value
            Double(lengthInMinutes)
        }
        set { // When the slider changes the value of lengthInMinutesAsDouble, convert the double value to an integer, and update the lengthInMinutes property.
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0)} // map(_:) creates a new collection by iterating over and applying a transformation to each element in an existing collection.
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}
// Add an extension that provides some sample data.
extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(
            title: "Design",
            attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
            lengthInMinutes: 10,
            theme: .yellow),
        DailyScrum(
            title: "App Dev",
            attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
            lengthInMinutes: 5,
            theme: .orange),
        DailyScrum(
            title: "Web Dev",
            attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
            lengthInMinutes: 5,
            theme: .poppy),
    ]
    // Add a static property named emptyScrum that returns an empty scrum
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
    }
}
// extension with an inner structure named Attendee that is identifiable.
// Scrum attendees could have the same name. Recall from Displaying data in a list that you can create a stable identifier when your model conforms to the Identifiable protocol.
extension DailyScrum {
    struct Attendee: Identifiable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
}
