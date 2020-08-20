//
//  SplashViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import NSObject_Rx
import KakaoSDKAuth
import RxKakaoSDKAuth

class SplashViewModel: BaseViewModel {
    
    func kakaoLoingAction() -> CocoaAction {
        return CocoaAction { _ in
            
            
            //            if isLo
            
            
            if (AuthApi.isKakaoTalkLoginAvailable()) {
                AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoTalk() success.")
                        print("\n====================")
                        print("oauthToken() success.:  ", oauthToken)
                        //do something
                        _ = oauthToken
                        
                        
                    }
                }
                let onboardNammingViewModel = OnBoardNameingViewModel(scenCoordinator: self.scenCoordinator)
                let onboardNammingScene = Scene.onboardNamming(onboardNammingViewModel)
//                return self.scenCoordinator.transition(to: onboardNammingScene, using: .root, animated: true).asObservable().map { _ in }
            }
            
            return Observable<Any>.empty().asObservable().map { _ in }
            
        }
    }
    
    func appleLoingAction() -> CocoaAction {
        return CocoaAction { _ in
        AppleID.login(controller: SplashViewController())
            
        return Observable<Any>.empty().asObservable().map { _ in }
        }
    }
    
    
    func mainAction() -> CocoaAction {
        return CocoaAction { _ in
            
            
            // TODO:  로그인 - 토큰 떨어지면 진행 화면 전환
            /*
             
             방방어 코드 작성
             
             */
            
            
            let mainViewModel = MainViewModel(scenCoordinator: self.scenCoordinator)
            let mainScene = Scene.main(mainViewModel)
            return self.scenCoordinator.transition(to: mainScene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
