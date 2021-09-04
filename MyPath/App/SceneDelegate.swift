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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .white
        
        window?.makeKeyAndVisible()
        
        coordinator = AuthCoordinator()
        coordinator?.start()
    }
}
