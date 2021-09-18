//
//  UserNotificationManager.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.09.2021.
//

import Foundation
import UserNotifications

final class UserNotificationManager {
    static let shared = UserNotificationManager()
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    func requestAuthorization() {
        userNotificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func add(notificationBuilder: UserNotificationRequestBuilder) {
        userNotificationCenter.add(notificationBuilder.build()) { error in
            if let error = error {
                debugPrint("Notification center add error: \(error.localizedDescription)")
            }
        }
        print("Notification added")
    }
    
    func remove(by identifier: UserNotificationIdentifiable) {
        print("Remove pending notification by \(identifier.identifier)")
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier.identifier])
    }
}
