//
//  OnBoardNameingViewController+Bind.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/10.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension OnBoardNameingViewController: ViewModelBindableType {

    
    func bindViewModel() {
        btnNext.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [unowned self] isSel in
                if self.btnNext.isSelected {
                    self.viewModel.nextAction(nickname: self.tvNickName.text)
                }
            })
            .disposed(by: rx.disposeBag)
            
    }
}
