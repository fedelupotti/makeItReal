//
//  ReminderToggleStyle.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 10/01/24.
//

import SwiftUI

struct ReminderToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn
                  ? "largecircle.fill.circle"
                  : "circle"
            )
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle( configuration.isOn
                              ? Color.accentColor
                              : Color.gray
            )
            .onTapGesture {
                configuration.isOn.toggle()
            }
            configuration.label
        }
    }
}

extension ToggleStyle where Self == ReminderToggleStyle {
    static var reminder: ReminderToggleStyle { .init() }
}

#Preview {
    NavigationView {
        @State var isOn = true

        Toggle(isOn: $isOn) {
            Text("Hello")
        }
        .toggleStyle(.reminder)
    }
}
