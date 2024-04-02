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
    case updating
    case adding
}

public class MockReminderRepository: ObservableObject, ReminderRepositoryProtocol {
        
    @Published internal var reminders = [Reminder]()
    
    var remindersPublisher: AnyPublisher<[Reminder], Never> { $reminders.eraseToAnyPublisher() }
    
    func addReminder(_ reminder: Reminder) throws {
        do {
            reminders.append(reminder)
        }
        catch let error as ErrorDescription {
            throw ErrorDescription.adding
        }
    }
    
    func deleteReminder(_ reminder: Reminder) {
        reminders.removeAll(where: { $0.id == reminder.id })
    }
    
    func updateReminder(_ reminder: Reminder) throws {
        let reminder = reminder
        guard let index = reminders.firstIndex(where: { $0.id == reminder.id}) else {
            throw ErrorDescription.updating
        }
        reminders[index] = reminder
    }
}
