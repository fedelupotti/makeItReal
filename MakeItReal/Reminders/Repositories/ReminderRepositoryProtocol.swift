//
//  ReminderRepositoryProtocol.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 06/03/24.
//

import Combine
import Foundation

protocol ReminderRepositoryProtocol: ObservableObject {
    var reminders: [Reminder] { get set }
    var remindersPublisher: Published<[Reminder]>.Publisher { get }
    
    func addReminder(_ reminder: Reminder) throws
    func deleteReminder(_ reminder: Reminder)
    func updateReminder(_ reminder: Reminder) throws
}
