//
//  WriteViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/18.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Action
// rx.disposeBag 사용하기
import NSObject_Rx
import NMapsMap

class WriteViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: WriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func bindViewModel() {
        
    }
    
}

extension WriteViewController {
    private func setUI() {
        self.view.backgroundColor = .white
        
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        
    }
}
