//
//  RemindersListViewModel.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 10/01/24.
//

import Combine
import Factory
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RemindersListViewModel: ObservableObject {
    
    @Published var reminders: [Reminder] = [Reminder]()
    
    @Published var errorMesagge: String?
    
    lazy private var cancellable = Set<AnyCancellable>()
    
    let remindersRepository: any ReminderRepositoryProtocol
    
    init(remindersRepository: any ReminderRepositoryProtocol = Container.shared.reminderRepository()) {
        self.remindersRepository = remindersRepository
        subscribe()
    }
    
    func subscribe() {
        remindersRepository
            .remindersPublisher
            .assign(to: &$reminders)
    }
    
    func addReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.addReminder(reminder)
            errorMesagge = nil
        }
        catch {
            print(error)
            errorMesagge = error.localizedDescription
        }
    }
    
    func deleteReminder(_ reminder: Reminder) {
        remindersRepository.deleteReminder(reminder)
    }
    
    func updateReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.updateReminder(reminder)
            errorMesagge = nil
        }
        catch {
            errorMesagge = error.localizedDescription
            print("Error when updating reminder: \(error)")
        }
    }
    
    func setCompleted(_ reminder: Reminder,_ isCompleted: Bool) {
        var reminder = reminder
        reminder.isCompleted = isCompleted
        updateReminder(reminder)
    }
    
    func hideRowReminder(_ reminder: Reminder) {
        var reminder = reminder
        reminder.isDeleting = true
        updateReminder(reminder)
    }
    
    func showReminderAgain(_ reminder: Reminder) {
        var reminder = reminder
        reminder.isDeleting = false
        updateReminder(reminder)
    }
    
}
