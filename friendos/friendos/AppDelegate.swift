//
//  AppDelegate.swift
//  friendos
//
//  Created by Daniel Ruiz on 3/15/22.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var apiKey: String {
      get {
          
        // 1
        guard let filePath = Bundle.main.path(forResource: "parse-api", ofType: "plist") else {
          fatalError("Couldn't find file 'parse-api.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_Key") as? String else {
          fatalError("Couldn't find key 'API_Key' in 'parse-api.plist'.")
        }
 
        return value
      }
    }
        
    private var clientKey: String {
      get {
          
        // 1
        guard let filePath = Bundle.main.path(forResource: "parse-api", ofType: "plist") else {
          fatalError("Couldn't find file 'parse-api.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "CLIENT_Key") as? String else {
          fatalError("Couldn't find key 'CLIENT_Key' in 'parse-api.plist'.")
        }

        return value
      }
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = self.apiKey
            $0.clientKey = self.clientKey
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

