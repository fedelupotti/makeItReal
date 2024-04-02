//
//  MakeItRealTests.swift
//  MakeItRealTests
//
//  Created by Federico Lupotti on 21/02/24.
//

import XCTest
import Combine
import Factory
@testable import MakeItReal

// Naming structure: test_UnitOfWork_StateUnderTest_ExcpectedBehaviour
// Naming structure: test_[Struct/Class] _ [Variable/function] _ expected result


class MakeItRealTests: XCTestCase {
    private var sut: RemindersListViewModel!
    private var mockReminderRespository: MockReminderRepository!
    
    override func setUpWithError() throws {
        mockReminderRespository = Container.shared.mockReminderRepository()
        sut = RemindersListViewModel(remindersRepository: mockReminderRespository)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ReminderListViewModel_addReminder_creatNewReminder() {
        //Given
        let reminder = Reminder(id: UUID().uuidString, title: "Write some tests")
        
        //When
        sut.addReminder(reminder)
        
        //Then
        XCTAssertTrue(sut.reminders.first != nil)
        XCTAssertEqual(sut.reminders.first?.id, reminder.id, "Reminders in mock repository: \(mockReminderRespository.reminders)")
        
    }

    func test_RemindersListViewModel_addReminder_incrementRemindersInOne() {
        //Given
        let reminder = Reminder(id: UUID().uuidString ,title: "Walk with Laika")
        let numberOfReminders = sut.reminders.count
        
        //When
        sut.addReminder(reminder)
        let numberOfRemindersAfterAdded = sut.reminders.count
        
        //Then
        XCTAssertEqual(numberOfRemindersAfterAdded, numberOfReminders + 1)
    }
    
    func test_RemindersListViewModel_deleteReminder_decreaseRemindersInOne() {
        //Given
        let reminder = Reminder(title: "Make some katesurf")
        sut.addReminder(reminder)
        let numberOfReminders = sut.reminders.count
        
        //When
        sut.deleteReminder(reminder)
        let numberOfRemindersAfterDelete = sut.reminders.count
        
        //Then
        XCTAssertEqual(numberOfRemindersAfterDelete, numberOfReminders - 1)
    }
    
    func test_RemindersListViewModel_deleteReminder_reminderRemovedShouldBeNil() {
        //Given
        let reminder = Reminder(id: UUID().uuidString, title: "This reminder should be delete")
        sut.addReminder(reminder)
        
        //When
        sut.deleteReminder(reminder)
        
        //Then
        let reminderDeleted = sut.reminders.first(where: { $0.id == reminder.id })
        XCTAssertNil(reminderDeleted)
    }
    
    func test_ReminderListViewModel_setCompleted_ToggleCompleateToTrue() {
        //Given
        let reminder = Reminder(id: UUID().uuidString, title: "This title will be changed")
        sut.addReminder(reminder)
        
        //When
        sut.setCompleted(reminder, true)
        
        //Then
        let updatedReminder = sut.reminders.first(where: { $0.id == reminder.id })
        XCTAssert(updatedReminder?.isCompleted == true)
    }
    
    func test_ReminderListViewModel_setCompleted_ToggleCompleateToFalse() {
        //Given
        let reminder = Reminder(id: UUID().uuidString, title: "This title will be changed", isCompleted: true)
        sut.addReminder(reminder)
        
        //When
        sut.setCompleted(reminder, false)
        
        //Then
        let updatedReminder = sut.reminders.first(where: { $0.id == reminder.id })
        XCTAssert(updatedReminder?.isCompleted == false)
    }
    
    func test_ReminderListViewModel_updateReminder_ThrowsUpdatingError() {
        //Given
        let reminder = Reminder(id: UUID().uuidString, title: "This reminder will never be added")
        
        //When
        //Reminder was never added
        sut.updateReminder(reminder)
        
        //Then
        XCTAssertEqual(sut.repositoryError, ErrorDescription.updating)
    }
}
