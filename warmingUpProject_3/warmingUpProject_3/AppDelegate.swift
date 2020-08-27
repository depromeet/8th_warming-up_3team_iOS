//
//  AppDelegate.swift
//  warmingUpProject_3
//
//  Created by JieunKim on 2020/08/01.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import NMapsMap
import RxKakaoSDKCommon
import KakaoSDKAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 카카오 로그인 연동
        RxKakaoSDKCommon.initSDK(appKey: "cca84244b21a13a5c1652e37106c9203")
        

        // 네이버 지도 연동
        NMFAuthManager.shared().clientId = "xm6p6sxsy2"
        
        let coordinator = SceneCoordinator(window: window!)
        let splahScene = Scene.splash
        coordinator.transition(to: splahScene, using: .root, animated: false)
//
//        let mainViewModel = MainViewModel(scenCoordinator: coordinator)
//        let splahScene = Scene.main(mainViewModel)
//        coordinator.transition(to: splahScene, using: .root, animated: false)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if (AuthApi.isKakaoTalkLoginUrl(url)) {            
            return AuthController.handleOpenUrl(url: url)
        }

        return false
    }
}

