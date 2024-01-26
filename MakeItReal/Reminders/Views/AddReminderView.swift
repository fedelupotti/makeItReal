//
//  AddReminderView.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 10/01/24.
//

import SwiftUI

struct AddReminderView: View {
    
    enum FocusableField: Hashable {
        case title
    }
    
    enum Mode {
        case add
        case edit
    }
    
    @FocusState private var focusedField: FocusableField?
    
    @State var reminder = Reminder(title: "")
    
    @Environment(\.dismiss) private var dismiss
    
    var mode: Mode = .add
    
    var onCommit: (_ reminder: Reminder) -> Void
    
    private func commit() {
        onCommit(reminder)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
                    .focused($focusedField, equals: .title)
            }
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: commit) {
                        Text( mode == .add ? "Add" : "Edit")
                    }
                    .disabled(reminder.title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: cancel, label: {
                        Text("Cancel")
                    })
                }
            }
            .onAppear {
                focusedField = .title
            }
        }
    }
}

#Preview {
    AddReminderView { reminder in
        print("You added a reminder with tittle: \(reminder.title)")
    }
}
