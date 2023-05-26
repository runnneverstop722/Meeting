//
//  ScrumStore.swift
//  Meeting
//
//  Created by Teff on 2023/05/26.
//

import Foundation

@MainActor // The class must be marked as @MainActor before it is safe to update the published scrums property from the asynchronous load() method.
class ScrumStore: ObservableObject { // ObservableObject is a class-constrained protocol for connecting external model data to SwiftUI views.
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL { // App will load&save scrums to a file in the user’s Documents folder. This func makes accessing the file easier.
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false) // Use the shared instance of the FileManager class to get the location of the Documents directory for the current user.
        .appendingPathComponent("scrums.data") //  Call it to return the URL of a file named scrums.data.
    }
    
    func load() async throws { // If an asynchronous function also throws an error, the async keyword comes before the throws keyword.
        let task = Task<[DailyScrum], Error> { // Store the task in a let constant so that later app can access values returned or catch errors thrown from the task. The parameters tell the compiler that your closure returns [DailyScrum] and can throw an Error.
            let fileURL = try Self.fileURL() // Use a guard statement to optionally load the file data.
            guard let data = try? Data(contentsOf: fileURL) else {
                return [] // Because the scrums.data file doesn’t exist at the beginning, so return an empty array if there’s an error reading the file.
            }
            let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            return dailyScrums // The value returned from the task closure is available when the task completes. Returning the array fixes the compiler error.
        }
        let scrums = try await task.value // `try await` to wait for the task to finish and assign the value to a constant named `scrums`. If the JSONDecoder throws an error inside the task, the error will be propagated when app tries to access the value property
        self.scrums = scrums // The type of task.value is the type that defined in the task initializer: [DailyScrum].
    }
    
    func save(scrums: [DailyScrum]) async throws {
        let task = Task { // Encoding scrums can fail, so handle any errors that occur.
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL() // Create a constant for the file URL.
            try data.write(to: outfile) // write the encoded data to the file.
        }
        _ = try await task.value // wait for the task to complete. Waiting for the task ensures that any error thrown inside the task will be reported to the caller. `_` indicates that we're not interested in the result of task.value.
    }
}
