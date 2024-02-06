//
//  ContentView.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 09/01/24.
//

import SwiftUI

struct ReminderListView: View {
    
    @StateObject private var viewModel = RemindersListViewModel()
    
    @State private var isSheetPresented = false
    
    @State private var editableReminder: Reminder? = nil
    
    @State private var showUndoButton = false
        
    @State private var undoReminder: Reminder? = nil {
        didSet {
            withAnimation {
                showUndoButton = undoReminder != nil
            }
        }
    }
    
    @State private var undoTimer: Timer?
    
    @State private var isDateViewPresented = false
            
    private func presentSheet() {
        isSheetPresented.toggle()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($viewModel.reminders) { $reminder in
                    Group {
                        if !reminder.isDeleting {
                            RemindersListRowView(reminder: $reminder)
                        }
                    }
                    
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            startDeletingAction(for: reminder)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .onTapGesture {
                        editableReminder = reminder
                        }
                        .onChange(of: reminder.isCompleted) { _, newValue in
                            viewModel.setCompleted(reminder, newValue)
                        }
                }
                
            }
            .scrollDismissesKeyboard(.immediately)
            .listStyle(.plain)
            .sheet(isPresented: $isDateViewPresented) {
                DateReminderView(reminder: $editableReminder)
            }
            .sheet(isPresented: $isSheetPresented) {
                AddReminderView { reminder in
                    viewModel.addReminder(reminder)
                }
            }
            //TODO: Show complete features
//            .sheet(item: $editableReminder) { reminder in
//                AddReminderView(reminder: reminder, mode: .edit) { reminder in
//                    viewModel.updateReminder(reminder)
//                }
//            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button {
                        guard let reminder = editableReminder else { return }
                        modifyDate(for: reminder)
                        isDateViewPresented = true
                        
                    } label: {
                        Image(systemName: "calendar.badge.clock")
                            .font(.title2)
                    }
                }
                
                ToolbarItem {
                    Button(action: presentSheet, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .navigationTitle("Reminders")
        }
        .safeAreaInset(edge: .bottom, alignment: .leading, spacing: 0) {
            if showUndoButton {
                ZStack (alignment: .bottomLeading) {
                    undoButton
                        .buttonStyle(.borderedProminent)
                }
                .padding(.leading, 30)
            }
        }
    }
    
    private func modifyDate(for reminder: Reminder) {
        
    }
    
    private func startDeletingAction(for reminder: Reminder) {
        undoReminder = reminder
        viewModel.hideRowReminder(reminder)
        
        undoTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            guard let undoReminder else { return }
            viewModel.deleteReminder(undoReminder)
            self.undoReminder = nil
            
        }
    }
    
    private func cancelDeletingAction(for reminder: Reminder) {
        viewModel.showReminderAgain(reminder)
        
        undoTimer?.invalidate()
        undoTimer = nil
        undoReminder = nil
    }
    
    private var undoButton: some View {
        Button {
            if let undoReminder {
                cancelDeletingAction(for: undoReminder)
            }
        } label: {
            HStack {
                Label("Undo", systemImage: "arrow.uturn.backward")
                    .font(.body)
            }
        }
    }
}

#Preview {
    ReminderListView()
}
