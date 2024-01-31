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
                        Text("Day")
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
            .onChange(of: isOnToggleDate) { _, newValue in
                newValue == false ? isOnToggleTime = false : nil
            }
            .onChange(of: isOnToggleTime) { _, newValue in
                newValue == true ? isOnToggleDate = true : nil
            }
        }
    }
}

#Preview {
    DateReminderView()
}
