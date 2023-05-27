//
//  ThemePicker.swift
//  Meeting
//
//  Created by Teff on 2023/05/22.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme // This binding communicates changes to the theme within the theme picker back to the parent view
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in //Add a ThemeView, and tag it with the theme. You can tag subviews when you need to differentiate among them in controls like pickers and lists. Tag values can be any hashable type like in an enumeration.
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink) // When a user interacts with a navigation style picker, the system pushes the picker view onto the navigation stack. The picker view displays each theme in a ThemeView that highlights the theme’s color.
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle)) // use the constant(_:) type method to create a binding to a hard-coded, immutable value. Constant bindings are useful in previews or when prototyping your app’s user interface.
    }
}
