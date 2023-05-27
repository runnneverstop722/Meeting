//
//  SpeakerArc.swift
//  Meeting
//
//  Created by Teff on 2023/05/27.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeaker: Int
    
    private var degreesPerSpeaker: Double {
        360.0 / Double(totalSpeaker)
    }
    private var startAngle: Angle { // Add a private computed property named startAngle, and calculate the value using degreesPerSpeaker and speakerIndex.
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0) // When draw a path, will need an angle for the start and end of the arc. The additional 1.0 degree is for visual separation between arc segments.
    }
    private var endAngle: Angle { // Add a private computed property named endAngle that returns the ending angle using the startAngle and degreesPerSpeaker.
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0) // The subtracted 1.0 degree is for visual separation between arc segments.
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0 // Create a constant diameter for the circle of the arc. The path(in:) function takes a CGRect parameter. The coordinate system contains an origin in the lower left corner, with positive values extending up and to the right.
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY) // Create a constant to store the center of the rectangle. The CGRect structure supplies two properties that provide the x- and y-coordinates for the center of the rectangle.
        return Path { path in // The Path initializer takes a closure that passes in a path parameter.
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
