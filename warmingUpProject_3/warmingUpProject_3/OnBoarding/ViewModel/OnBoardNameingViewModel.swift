//
//  OnBoardNameingViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class OnBoardNameingViewModel: BaseViewModel {
    
    func nextAction() -> CocoaAction {
        return CocoaAction { _ in
            print(1331)
            /*
             api 검증 해서 아이디 중복없으면 넘어가고
             아니면 팝업띄우는걸로 구현해야함
             */

             let onboardTypeViewModel = OnBoardTypeViewModel(scenCoordinator: self.scenCoordinator)
            let onBoardTypeScene = Scene.onboardType(onboardTypeViewModel)
            return self.scenCoordinator.transition(to: onBoardTypeScene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}

