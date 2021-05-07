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
    func requestSingUp() {
        provider.rx
            .request(.signUp(nickName: UserUtils.getNickName(), type: UserUtils.getType(), snsType: UserUtils.getSnsType(), snsLoginID: String(UserUtils.getSnsID()!)))
            .filterSuccessfulStatusCodes()
            .map(SingUpModel.self)
            .subscribe(onSuccess: { [unowned self] (_) in
                // TODO: API 응답 데이터가 바뀌야함
             
                self.nextAction()
            }) { (err) in
                print(err)
        }.disposed(by: rx.disposeBag)
    }
    
    func nextAction() {
        let mainViewModel = MainViewModel(scenCoordinator: self.scenCoordinator)
        let onBoardTypeScene = Scene.main(mainViewModel)
        self.scenCoordinator.transition(to: onBoardTypeScene, using: .root, animated: true)
    }
    
    let lotties = ["onboarding1", "onboarding2", "onboarding3"]
}
