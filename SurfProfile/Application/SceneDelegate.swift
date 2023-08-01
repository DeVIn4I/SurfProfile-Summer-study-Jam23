//
//  SceneDelegate.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: ProfileViewController())
        window?.makeKeyAndVisible()
    }
}

