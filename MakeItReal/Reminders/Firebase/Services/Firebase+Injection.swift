//
//  Firebase+Injection.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 21/01/24.
//

import Foundation
import Factory
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

extension Container {
    
    public var useEmulator: Factory<Bool> {
        Factory(self) {
            let value = UserDefaults.standard.bool(forKey: "useEmulator")
            print("Using the emulator: \(value ? "YES" : "NO" )")
            return value
        }.singleton
    }
    
    public var firestore: Factory<Firestore> {
        
        Factory(self) {
            
            var environment = ""
            
            if Container.shared.useEmulator() {
                
                let settings = Firestore.firestore().settings
                settings.host = "localhost: 8080"
                settings.isSSLEnabled = false
                settings.cacheSettings = MemoryCacheSettings()
                
                Firestore.firestore().settings = settings
                Auth.auth().useEmulator(withHost: "localhost", port: 9099)
                
                environment = "Emulator on \(settings.host)"
                
            } else {
                environment = "Firebase backend"
            }
            
            print("Environment in use: \(environment)")
            return Firestore.firestore()
        }.singleton
    }
}
