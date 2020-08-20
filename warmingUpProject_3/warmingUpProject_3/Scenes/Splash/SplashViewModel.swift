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

class SplashViewModel: BaseViewModel {

    func kakaoLoingAction() -> CocoaAction {
        return CocoaAction { _ in


            // TODO:  로그인 - 토큰 떨어지면 진행 화면 전환
            /*

             방방어 코드 작성

             */
            let xx = UIButton()
            xx.rx.tap.throttle(<#T##dueTime: RxTimeInterval##RxTimeInterval#>, scheduler: <#T##SchedulerType#>).subscribe(<#T##observer: ObserverType##ObserverType#>)


            let onboardNammingViewModel = OnBoardNameingViewModel(scenCoordinator: self.scenCoordinator)
            let onboardNammingScene = Scene.onboardNamming(onboardNammingViewModel)
            return self.scenCoordinator.transition(to: onboardNammingScene, using: .root, animated: true).asObservable().map { _ in }
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
