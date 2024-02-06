//
//  DateReminderView.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 30/01/24.
//

import SwiftUI

struct DateReminderView: View {
    
    @Binding var reminder: Reminder?
    
    @State private var isOnToggleDate = true
    
    @State private var isOnToggleTime = false
    
    @State private var dateSelected = Date()
    
    @State private var timeSelected = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $isOnToggleDate) {
                    HStack(alignment: .center) {
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                            .font(.title2)
                        VStack(alignment: .leading) {
                            Text("Day")
                            if isOnToggleDate {
                                Text("\(formatDateString())")
                                    .foregroundStyle(.blue)
                                    .font(.caption)
                            }
                            
                        }
                    }
                }
                if isOnToggleDate {
                    DatePicker("", selection: $dateSelected, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .onChange(of: dateSelected) { _, newDateSelected in
                            reminder?.date = newDateSelected
                        }
                }
                
                Toggle(isOn: $isOnToggleTime) {
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(.blue)
                            .font(.title2)
                        Text("Time")
                    }
                }
                if isOnToggleTime {
                    DatePicker("", selection: $timeSelected, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .onChange(of: timeSelected) { _, newTimeSelected in
                            reminder?.time = newTimeSelected
                        }
                }
                
            }
            .navigationTitle("Date & Time")
            .navigationBarTitleDisplayMode(.inline)
            
            .onChange(of: isOnToggleDate) { _, newValue in
                newValue == false ? isOnToggleTime = false : nil
            }
            .onChange(of: isOnToggleTime) { _, newValue in
                newValue == true ? isOnToggleDate = true : nil
            }
            .onAppear {
                reminder?.date = dateSelected
            }
            
        }
    }
    
    private func formatDateString() -> String {
        let date = reminder?.date ?? Date()
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: date)
        }
    }
}

#Preview {
    NavigationView {
        @State var reminderMock = Reminder.samples.first
        DateReminderView(reminder: $reminderMock)
    }
}
