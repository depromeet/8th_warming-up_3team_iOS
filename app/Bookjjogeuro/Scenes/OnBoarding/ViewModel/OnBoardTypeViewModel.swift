//
//  OnBoardTypeViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class OnBoardTypeViewModel: BaseViewModel {
    var nickName = ""
    
    var profileType = 0
    
    func nextAction()  {
        let onboardExplanationViewModel = OnBoardExplanationViewModel(scenCoordinator: self.scenCoordinator)
        let onBoardTypeScene = Scene.onboardExplanation(onboardExplanationViewModel)
        self.scenCoordinator.transition(to: onBoardTypeScene, using: .root, animated: true)        
    }
}
