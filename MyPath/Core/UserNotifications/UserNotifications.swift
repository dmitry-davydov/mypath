//
//  UserNotifications.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.09.2021.
//

import Foundation
import UserNotifications

protocol AppUserNotificationContentProtocol {
    var content: UNNotificationContent { get }
}

protocol AppUserNotificationIdentifiable {
    var identifier: String { get }
}

protocol AppUserNotificationProtocol: AppUserNotificationContentProtocol, AppUserNotificationIdentifiable {}


protocol AppUserNotificationTriggerProtocol {
    var trigger: UNNotificationTrigger { get }
}

enum AppUserNotificationTrigger: AppUserNotificationTriggerProtocol {
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

struct AppUserNotificationRequestBuilder {
    let notificationKind: AppUserNotificationProtocol
    let trigger: AppUserNotificationTriggerProtocol
    
    func build() -> UNNotificationRequest {
        return UNNotificationRequest(
            identifier: notificationKind.identifier,
            content: notificationKind.content,
            trigger: trigger.trigger
        )
    }
}
