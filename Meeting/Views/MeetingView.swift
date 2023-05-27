//
//  MeetingView.swift
//  Meeting
//
//  Created by Teff on 2023/05/21.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer() // Wrapping a property as a @StateObject means the view owns the source of truth for the object. @StateObject ties the ScrumTimer (ObservableObject), to the MeetingView life cycle.
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme) // Add a call to the meeting header subview that uses scrumTimer to provide the secondsElapsed and secondsRemaining arguments.
                MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            startScrum()
        }
        .onDisappear {
            stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees) // The timer resets each time an instance of MeetingView shows on screen, indicating that a meeting should begin.
        scrumTimer.speakerChangedAction = { // ScrumTimer calls this action when a speaker’s time expires.
            player.seek(to: .zero) // Seek to time .zero in the audio file to always plays from the beginning.
            player.play() // Play the audio file.
        }
        scrumTimer.startScrum() // Call scrumTimer.startScrum() to start a new scrum timer after the timer resets.
    }
    private func stopScrum() {
        scrumTimer.stopScrum() // The timer stops each time an instance of MeetingView leaves the screen, indicating that a meeting has ended.
        let newHistory = History(attendees: scrum.attendees) // Create a History, and insert it into scrum.history.
        scrum.history.insert(newHistory, at: 0)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
