//
//  DateReminderView.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 30/01/24.
//

import SwiftUI

struct DateReminderView: View {
    
    
    
    @State private var isOnToggleDate = true
    
    @State private var isOnToggleTime = false
    
    @State private var dateSelected = Date()
    
    @State private var timeSelected = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $isOnToggleDate) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                            .font(.title2)
                        VStack(alignment: .leading) {
                            Text("Day")
                            Text("dateSelected")
                                .foregroundStyle(.blue)
                                .font(.caption)
                        }
                    }
                }
                if isOnToggleDate {
                    DatePicker("", selection: $dateSelected, displayedComponents: .date)
                        .datePickerStyle(.graphical)
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
            
        }
    }
    
    private func formatDateString(_ dateString: String, unreadMessagesCount: Int?) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let unreadMessagesCount {
            return "\(unreadMessagesCount) new"
        }
        
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        
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
    DateReminderView()
}
