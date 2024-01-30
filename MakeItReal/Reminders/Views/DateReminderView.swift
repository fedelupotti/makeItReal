//
//  DateReminderView.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 30/01/24.
//

import SwiftUI

struct DateReminderView: View {
    
    @State private var isOnToggleDate = true 
    
    @State private var isOnToggleHour = false
    
    @State private var dateSelected = Date()
    
    @State private var hourSelected = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $isOnToggleDate) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                            .font(.title2)
                        Text("Day")
                    }
                }
                if isOnToggleDate {
                    DatePicker("", selection: $dateSelected, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
                
                Toggle(isOn: $isOnToggleHour) {
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(.blue)
                            .font(.title2)
                        Text("Time")
                    }
                }
                if isOnToggleHour {
                    DatePicker("", selection: $dateSelected, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                }
                
            }
        }
    }
}

#Preview {
    DateReminderView()
}
