//
//  ErrorView.swift
//  Meeting
//
//  Created by Teff on 2023/05/26.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper // Add a constant ErrorWrapper property.
    
    var body: some View {
        VStack {
            Text("An error has occurred")
                .font(.title)
                .padding(.bottom)
            Text(errorWrapper.error.localizedDescription) // Error provides a localized string description. If the error’s user info dictionary doesn’t provide a value for the description key, the system constructs a localized string from the domain and code.
                .font(.headline)
            Text(errorWrapper.guidance)
                .font(.caption)
                .padding(.top)
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired,
                     guidance: "You can safely ignore this error.")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
