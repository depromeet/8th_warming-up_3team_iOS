//
//  OnBoardExplanationViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class OnBoardExplanationViewModel: BaseViewModel {
    func nextAction() -> CocoaAction {
        return CocoaAction { _ in
             let mainViewModel = MainViewModel(scenCoordinator: self.scenCoordinator)
            let onBoardTypeScene = Scene.main(mainViewModel)
            return self.scenCoordinator.transition(to: onBoardTypeScene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
