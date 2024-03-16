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


final class MakeItRealTests: XCTestCase {
    var sut: RemindersListViewModel!
    var mockReminderRespository: MockReminderRepository!

    override func setUpWithError() throws {
        mockReminderRespository = Container.shared.mockReminderRepository()
        sut = RemindersListViewModel(remindersRepository: mockReminderRespository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ReminderListViewModel_addReminder_creatNewReminder() {
        //Given
        let reminder = Reminder(id: "1234", title: "Write some tests")
        
        //When
        sut.addReminder(reminder)
        
        //Then
        XCTAssertTrue(sut.reminders.first != nil)
        XCTAssertEqual(sut.reminders.first?.id, "1234", "Reminders in mock repository: \(mockReminderRespository.reminders)")
        
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
        let reminder = Reminder(title: "Make some kate")
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
        let reminder = Reminder(id: "1234", title: "This reminder should be delete")
        sut.addReminder(reminder)
        
        //When
        sut.deleteReminder(reminder)
        
        //Then
        let reminderDeleted = sut.reminders.first(where: { $0.id == "1234" })
        XCTAssertNil(reminderDeleted)
    }
    
    func test_ReminderListViewModel_updateReminder_sameIdAfterModifyReminder() {
        /
    }
}
