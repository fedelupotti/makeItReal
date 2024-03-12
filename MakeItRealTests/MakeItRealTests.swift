//
//  MakeItRealTests.swift
//  MakeItRealTests
//
//  Created by Federico Lupotti on 21/02/24.
//

import XCTest
import Combine
@testable import MakeItReal

// Naming structure: test_UnitOfWork_StateUnderTest_ExcpectedBehaviour
// Naming structure: test_[Struct/Class] _ [Variable/function] _ expected result


final class MakeItRealTests: XCTestCase {
    var homeViewModel: RemindersListViewModel!

    override func setUpWithError() throws {
        homeViewModel = RemindersListViewModel(remindersRepository: MockReminderRepository())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_RemindersListViewModel_addReminder_incrementRemindersInOne() {
        //Given
        let reminder = Reminder(title: "Walk with Laika")
        let numberOfReminders = homeViewModel.reminders.count
        
        //When
        homeViewModel.addReminder(reminder)
        let numberOfRemindersAfterAdded = homeViewModel.reminders.count
        
        //Then
        XCTAssertEqual(numberOfRemindersAfterAdded, numberOfReminders + 1)
    }
    
    func test_RemindersListViewModel_deleteReminder_decreaseRemindersInOne() {
        //Given
        let reminder = Reminder(title: "Make some kate")
        homeViewModel.addReminder(reminder)
        let numberOfReminders = homeViewModel.reminders.count
        
        //When
        homeViewModel.deleteReminder(reminder)
        let numberOfRemindersAfterDelete = homeViewModel.reminders.count
        
        //Then
        XCTAssertEqual(numberOfRemindersAfterDelete, numberOfReminders - 1)
    }

}
