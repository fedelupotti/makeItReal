//
//  Reminder.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 09/01/24.
//

import Foundation
import FirebaseFirestore


struct Reminder: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var isCompleted = false
}

extension Reminder {
    static let samples: [Reminder] = [
        Reminder(title: "Make a trip to Bali", isCompleted: false),
        Reminder(title: "Run with Laika", isCompleted: false),
        Reminder(title: "Little holidays with frinds", isCompleted: true)
    ]
}

extension Reminder {
    static let collectionName = "reminders"
}
