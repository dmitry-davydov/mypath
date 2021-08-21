//
//  SceneDelegate.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .white
        
     
        let rootViewController = MainFlowFactory().construct()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}
