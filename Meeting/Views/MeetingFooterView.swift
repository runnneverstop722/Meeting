//
//  MeetingFooterView.swift
//  Meeting
//
//  Created by Teff on 2023/05/24.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    let skipAction: () -> Void // SkipAction closure property to the view
    
    private var speakerNumber: Int? { // Add a private computed property that determines the speaker number
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    } // ScrumTimer marks each speaker as completed when their time has ended. The first speaker not marked as completed becomes the active speaker. The speakerNumber property uses the index to return the active speaker number, which you’ll use as part of the footer text.
    
    private var isLastSpeaker: Bool { // Add a private computed property that checks whether the active speaker is the last speaker. This property is true if the isCompleted property of each speaker except the final speaker is true.
        return speakers.dropLast().allSatisfy { $0.isCompleted }
        // Can code like this: return speakers.dropLast().reduce(true) { $0 && $1.isCompleted }
    }
    
    private var speakerText: String { // Add a private computed property that returns information about the active speaker, and pass it to the Text view. The property returns Speaker X of Y when there are remaining speakers or No more speakers when the meeting exceeds the allotted time.
        guard let speakerNumber = speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
        
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {}) // skipAction to allow users to skip to the next speaker
            .previewLayout(.sizeThatFits) // Set the preview layout to sizeThatFits for a more accurate representation of the subview’s size.
    }
}
