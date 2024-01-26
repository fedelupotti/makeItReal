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
    
    @State private var isBookmarked = 2.0
    
    private func presentSheet() {
        isSheetPresented.toggle()
    }
    
    var body: some View {
        NavigationStack {
            List($viewModel.reminders) { $reminder in
                RemindersListRowView(reminder: $reminder)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.deleteReminder(reminder)
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
            .listStyle(.plain)
            .sheet(isPresented: $isSheetPresented) {
                AddReminderView { reminder in
                    viewModel.addReminder(reminder)
                }
            }
            .sheet(item: $editableReminder) { reminder in
                AddReminderView(reminder: reminder, mode: .edit) { reminder in
                    viewModel.updateReminder(reminder)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: presentSheet, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .navigationTitle("Reminders")
//            .onTapGesture {
//                isBookmarked.toggle()
//            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            tabBar
        }
    }
    var tabBar: some View {
        HStack {

            Label {
                Text("Archive")
            } icon: {
                Image(systemName: "archivebox")
                    .overlay {
                        Circle()
                            .stroke(.red)
                            .scaleEffect(isBookmarked)
                            .opacity(2.0 - isBookmarked )
                            .animation(.easeOut(duration: 1).repeatForever(), value: isBookmarked)
                    }
                    .onTapGesture {
                        isBookmarked = 2
                    }
                
                
                
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
