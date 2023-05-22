//
//  DetailView.swift
//  Meeting
//
//  Created by Teff on 2023/05/22.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Wrap DetailView in a NavigationStack to preview navigation elements on the canvas.
        NavigationStack {
            DetailView(scrum: DailyScrum.sampleData[0])
        }
    }
}
