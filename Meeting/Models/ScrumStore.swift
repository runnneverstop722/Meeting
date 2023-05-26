//
//  ScrumStore.swift
//  Meeting
//
//  Created by Teff on 2023/05/26.
//

import Foundation

class ScrumStore: ObservableObject { // ObservableObject is a class-constrained protocol for connecting external model data to SwiftUI views.
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL { // App will load&save scrums to a file in the user’s Documents folder. This func makes accessing the file easier.
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false) // Use the shared instance of the FileManager class to get the location of the Documents directory for the current user.
        .appendingPathComponent("scrums.data") //  Call it to return the URL of a file named scrums.data.
    }
}
