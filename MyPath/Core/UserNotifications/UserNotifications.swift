//
//  UserNotifications.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.09.2021.
//

import Foundation
import UserNotifications

protocol UserNotificationContentProtocol {
    var content: UNNotificationContent { get }
}

protocol UserNotificationIdentifiable {
    var identifier: String { get }
}

protocol UserNotificationProtocol: UserNotificationContentProtocol, UserNotificationIdentifiable {}

// MARK: - UserNotificationProtocol
enum UserNotifications: UserNotificationProtocol {
    case checkLastPath
    
    var content: UNNotificationContent {
        switch self {
        case .checkLastPath:
            let content = UNMutableNotificationContent()
            content.title = "Check for your paths"
            content.body = "The last path is ready to check"
            content.sound = .default
            return content
        }
    }
    
    var identifier: String {
        switch self {
        case .checkLastPath: return "checkLastPath"
        }
    }
}

protocol UserNotificationTriggerProtocol {
    var trigger: UNNotificationTrigger { get }
}

enum UserNotificationTrigger: UserNotificationTriggerProtocol {
    case timeInterval(seconds: Double, repeats: Bool)
    case dateComponent(hour: Int, minute: Int, repeats: Bool)
    
    var trigger: UNNotificationTrigger {
        switch self {
        case let .timeInterval(seconds, repeats):
            return UNTimeIntervalNotificationTrigger(
                timeInterval: seconds,
                repeats: repeats
            )
        case let .dateComponent(hour, minute, repeats):
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = minute
            
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        }
    }
}

struct UserNotificationRequestBuilder {
    let notificationKind: UserNotificationProtocol
    let trigger: UserNotificationTriggerProtocol
    
    func build() -> UNNotificationRequest {
        return UNNotificationRequest(
            identifier: notificationKind.identifier,
            content: notificationKind.content,
            trigger: trigger.trigger
        )
    }
}
