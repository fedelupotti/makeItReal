//
//  ContentView.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 09/01/24.
//

import SwiftUI
import Pow

struct ReminderListView: View {
    
    @StateObject private var viewModel = RemindersListViewModel()
    
    @State private var isSheetPresented = false
    
    @State private var editableReminder: Reminder? = nil
        
    @State private var undoReminder: Reminder? = nil
    
    @State private var undoTimer: Timer?
            
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
                            //                                viewModel.deleteReminder(reminder)
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
                ToolbarItem {
                    Button(action: presentSheet, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .navigationTitle("Reminders")
        }
        .safeAreaInset(edge: .bottom, alignment: .leading, spacing: 0) {
            //            tabBar
            
            if let undoReminder {
                ZStack (alignment: .bottomLeading) {
                    undoButton
                        .buttonStyle(.borderedProminent)
                }
                .padding(.leading, 30)
            }
        }
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
            withAnimation(.easeIn(duration: 2)) {
                if let undoReminder {
                    cancelDeletingAction(for: undoReminder)
                }
            }
            
        } label: {
            HStack {
                Label("Undo", systemImage: "arrow.uturn.backward")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(undoReminder != nil ? 90 : 0))
                    .scaleEffect(undoReminder != nil ? 1.5 : 1)
                    .padding()
                
            }
        }
    }
    
    var tabBar: some View {
        HStack {

            Label {
                Text("Archive")
            } icon: {
                Image(systemName: "archivebox")
//                    .changeEffect(.jump(height: 50), value: isBookmarked, isEnabled: isBookmarked)
            }
            
            Label("Profile", systemImage: "person")
        }
        .labelStyle(SocialFeedTabBarLabelStyle(isSelected: false))
        .padding(12)
        .padding(.bottom, 2)
        .background(.regularMaterial, in: Capsule(style: .continuous))
        .padding(.horizontal)
    }
}



private struct SocialFeedTabBarLabelStyle: LabelStyle {
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 6) {
            configuration.icon
                .imageScale(.medium)
                .symbolVariant(isSelected ? .fill : .none)
                .font(.system(size: 22))
        }
        .foregroundStyle(isSelected ? AnyShapeStyle(.tint) : AnyShapeStyle(Color.primary))
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ReminderListView()
}
