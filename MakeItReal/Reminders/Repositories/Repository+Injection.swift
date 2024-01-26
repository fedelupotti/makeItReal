//
//  Repository+Injection.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 21/01/24.
//

import Foundation
import Factory


extension Container {
    
    public var reminderRepository: Factory<RemindersRepository> {
        //Here we are using self like Factory(self)
        self {
            RemindersRepository()
        }
        .singleton
    }
}
