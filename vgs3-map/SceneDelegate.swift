//
//  SceneDelegate.swift
//  vgs3-map
//
//  Created by Денис Наумов on 08.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var isMap = false

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // get Window Scene
        // get ws root VC
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
