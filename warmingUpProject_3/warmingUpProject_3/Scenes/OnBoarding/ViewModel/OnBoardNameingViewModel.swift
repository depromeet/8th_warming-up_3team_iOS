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
    
    func nextAction(nickname: String) {
        let onboardTypeViewModel = OnBoardTypeViewModel(scenCoordinator: self.scenCoordinator)
        onboardTypeViewModel.nickName = nickname
        let onBoardTypeScene = Scene.onboardType(onboardTypeViewModel)
        self.scenCoordinator.transition(to: onBoardTypeScene, using: .root, animated: true)
    }
}
