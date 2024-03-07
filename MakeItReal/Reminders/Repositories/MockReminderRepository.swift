//
//  MockReminderRepository.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 06/03/24.
//
import Combine
import Foundation

enum ErrorDescription: Error {
    case notFound
}

public class MockReminderRepository: ObservableObject, ReminderRepositoryProtocol {
    
    @Published var reminders = [Reminder]()
    
    func addReminder(_ reminder: Reminder) throws {
        reminders.append(reminder)
    }
    
    func deleteReminder(_ reminder: Reminder) {
        reminders.removeAll(where: { $0.id == reminder.id })
    }
    
    func updateReminder(_ reminder: Reminder) throws {
        var reminder = reminder
        guard let index = reminders.firstIndex(where: { $0.id == reminder.id}) else {
            throw ErrorDescription.notFound
        }
        reminders[index] = reminder
    }
}