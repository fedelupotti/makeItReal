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
    
//    private var remindersRepository: RemindersRepository = RemindersRepository()
    @Injected(\.reminderRepository) private var remindersRepository: RemindersRepository
    
    init() {
        subscribe()
    }
    
    func subscribe() {
        remindersRepository
            .$reminders
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
    
}
