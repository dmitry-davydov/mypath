//
//  AppDelegate.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(AppConfiguration.GoogleMaps.apiKey)
        
        UserNotificationManager.shared.requestAuthorization()
            
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
        UserNotificationManager.shared.add(
            notificationBuilder: AppUserNotificationRequestBuilder(
                notificationKind: AppUserNotifications.checkLastPath,
                trigger: AppUserNotificationTrigger.timeInterval(seconds: 30, repeats: false)
            )
        )
    }
}
