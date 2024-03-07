//
//  ReminderRepositoryProtocol.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 06/03/24.
//

import Foundation

protocol ReminderRepositoryProtocol {
    func addReminder(_ reminder: Reminder) throws
    func deleteReminder(_ reminder: Reminder)
    func updateReminder(_ reminder: Reminder) throws
}
