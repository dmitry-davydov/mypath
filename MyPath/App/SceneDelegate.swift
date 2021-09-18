//
//  SceneDelegate.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: BaseCoordinator?
    
    var workingWindow: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .white
        
        window?.makeKeyAndVisible()
        workingWindow = window
        coordinator = AuthCoordinator()
        coordinator?.start()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        workingWindow = window
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        window = workingWindow
        window?.makeKeyAndVisible()
        
        UserNotificationManager.shared.remove(by: AppUserNotifications.checkLastPath)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground")
        sendBackUserNotification()
    }
    
    private func sendBackUserNotification() {
        UserNotificationManager.shared.add(
            notificationBuilder: AppUserNotificationRequestBuilder(
                notificationKind: AppUserNotifications.checkLastPath,
                trigger: AppUserNotificationTrigger.timeInterval(seconds: 30, repeats: false)
            )
        )
    }
    
}
