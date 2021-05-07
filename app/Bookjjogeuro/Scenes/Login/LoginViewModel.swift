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
import KakaoSDKUser
import Moya

class LoginViewModel: BaseViewModel {
    func kakaoLoingAction() {
        UserUtils.setSnsType(name: "kakao")
        
        
//        if (AuthApi.isKakaoTalkLoginAvailable()) {
//            AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
//                        if let error = error {
//                            print(error)
//                        }
//                        else {
//                            print("accessTokenInfo() success.")
//                            UserUtils.setSnsID(Id: accessTokenInfo?.id ?? Int64(0))
//
//                            let onboardNammingViewModel = OnBoardNameingViewModel(scenCoordinator: self.scenCoordinator)
//                            let onboardNammingScene = Scene.onboardNamming(onboardNammingViewModel)
//
//                            self.scenCoordinator.transition(to: onboardNammingScene, using: .root, animated: true)
//                        }
//                    }
//                }
//            }
//        }
        
    }
    
    func appleLoingSucceed() {
        let onboardNammingViewModel = OnBoardNameingViewModel(scenCoordinator: self.scenCoordinator)
        let onboardNammingScene = Scene.onboardNamming(onboardNammingViewModel)
        
        self.scenCoordinator.transition(to: onboardNammingScene, using: .root, animated: true)
    }
    
    func appleLoingAction() -> CocoaAction {
        return CocoaAction { _ in
            UserUtils.setSnsType(name: "apple")
            
            if #available(iOS 13.0, *) {
                AppleID.login(controller: LoginViewController())
            } else {
                // Fallback on earlier versions
            }
            
            return Observable<Any>.empty().asObservable().map { _ in }
        }
    }
    
    
    func mainAction() -> CocoaAction {
        return CocoaAction { _ in
            // TODO:  로그인 - 토큰 떨어지면 진행 화면 전환
            /*
             
             방방어 코드 작성
             
             */
            
            print(12348912)
            let mainViewModel = MainViewModel(scenCoordinator: self.scenCoordinator)
            let mainScene = Scene.main(mainViewModel)
            return self.scenCoordinator.transition(to: mainScene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
