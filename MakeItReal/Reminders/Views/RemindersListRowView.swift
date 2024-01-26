//
//  RemindersListRowView.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 10/01/24.
//

import SwiftUI

struct RemindersListRowView: View {
    
    @Binding var reminder: Reminder
    
    var body: some View {
        HStack {
            Toggle(isOn: $reminder.isCompleted) { }
                .toggleStyle(.reminder)
            Text(reminder.title)
        }
    }
}

#Preview {
    NavigationView {
        @State var reminderMock = Reminder.samples.first!
        
        List {
            RemindersListRowView(reminder: $reminderMock)
        }
    }
}
