//
//  RemindersRepository.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 11/01/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Factory

public class RemindersRepository: ObservableObject, ReminderRepositoryProtocol {
    
    @Published var reminders = [Reminder]()
    
    private var listenerRegistration: ListenerRegistration?
    
    @Injected(\.firestore) private var firestore
    
    init() {
        subscribe()
    }
    
    deinit {
        unsubscribe()
    }
    
    func addReminder(_ reminder: Reminder) throws {
        try firestore
            .collection(Reminder.collectionName)
            .addDocument(from: reminder)
    }
    
    func deleteReminder(_ reminder: Reminder) {
        guard let documentId = reminder.id else {
            fatalError("There is no id for document: \(reminder.title)")
        }
        
        firestore
            .collection(Reminder.collectionName)
            .document(documentId)
            .delete()
    }
    
    func updateReminder(_ reminder: Reminder) throws {
        
        guard let documentId = reminder.id else {
            fatalError("There is no id for document: \(reminder.title)")
        }
        
        try firestore
            .collection(Reminder.collectionName)
            .document(documentId)
            .setData(from: reminder, merge: true)
    }

    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    
    func subscribe() {
        
        if listenerRegistration == nil {
            let query = firestore.collection(Reminder.collectionName)
            
            listenerRegistration = query
                .addSnapshotListener { [weak self] querySnapshot, error in
                    
                    guard let documentsSnapshot = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }
                    
                    self?.reminders = documentsSnapshot.compactMap { documentSnapshot in
                        do {
                            return try documentSnapshot.data(as: Reminder.self)
                        }
                        catch {
                            print("Fail to map document id: \(documentSnapshot.documentID) with error: \(error)")
                            return nil
                        }
                    }
                }
        }
    }
}
