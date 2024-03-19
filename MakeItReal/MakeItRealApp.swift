//
//  MakeItRealApp.swift
//  MakeItReal
//
//  Created by Federico Lupotti on 09/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


final class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      
//      let useEmulator = UserDefaults.standard.bool(forKey: "useEmulator")
//      
//      if useEmulator {
//          let settings = Firestore.firestore().settings
//          settings.host = "localhost: 8080"
//          settings.isSSLEnabled = false
//          Firestore.firestore().settings = settings
//          
//          Auth.auth().useEmulator(withHost: "localhost", port: 9099)
//      }
//      
    return true
  }
}

@main
struct MakeItRealApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ReminderListView()
            }
        }
    }
}
