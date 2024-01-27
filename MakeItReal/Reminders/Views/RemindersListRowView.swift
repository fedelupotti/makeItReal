//
//  RemindersListRowView.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 10/01/24.
//

import SwiftUI

struct RemindersListRowView: View {
    
    @Binding var reminder: Reminder
        
    @FocusState private var isBeingModifing: Bool
    
    var body: some View {
        HStack {
            Toggle(isOn: $reminder.isCompleted) { }
                .toggleStyle(.reminder)
            TextField("", text: $reminder.title)
                .focused($isBeingModifing)
                
                Image(systemName: "\(isBeingModifing ? "info.circle.fill" : "")")
                    .foregroundStyle(.orange)
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
