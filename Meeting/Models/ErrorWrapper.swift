//
//  ErrorWrapper.swift
//  Meeting
//
//  Created by Teff on 2023/05/26.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) { // Create an initializer that accepts an error and a guidance string and assigns a default value for id.
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
