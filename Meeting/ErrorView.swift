//
//  ErrorView.swift
//  Meeting
//
//  Created by Teff on 2023/05/26.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper // Add a constant ErrorWrapper property.
    @Environment(\.dismiss) private var dismiss // With the @Environment property wrapper, we can read a value that the view’s environment stores, such as the view’s presentation mode, scene phase, visibility, or color scheme. In this case, we’ll access the view’s dismiss structure and call it like a function to dismiss the view.
    
    var body: some View {
        NavigationStack {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { // The Dismiss button will be on the trailing side of the user interface.
                Button("dismiss") {
                    dismiss()
                }
            }
        }
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
