//
//  MeetingTimerView.swift
//  Meeting
//
//  Created by Teff on 2023/05/27.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let isRecording: Bool
    let theme: Theme
    
    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone" // The current speaker is the first person on the list who hasn’t spoken. If there isn’t a current speaker, the expression returns “Someone.
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription") // VoiceOver users might be unable to use visual cues, so include auditory indicators in addition to visual ones.
                }
                .accessibilityElement(children: .combine) // Use the accessibilityElement modifier to combine the elements inside the VStack. This modifier makes VoiceOver read the two text views as one sentence.
                .foregroundStyle(theme.accentColor)
            }
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bill", isCompleted: true), ScrumTimer.Speaker(name: "Teff", isCompleted: false)]
    }
    
    static var previews: some View {
        MeetingTimerView(speakers: speakers, isRecording: true ,theme: .yellow)
    }
}
