//
//  AppNotifications.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.09.2021.
//

import Foundation
import UserNotifications

// MARK: - UserNotificationProtocol
enum AppUserNotifications: AppUserNotificationProtocol {
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
