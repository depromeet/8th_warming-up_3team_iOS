//
//  SplashViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/03.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//import NSObject_Rx

final class SplashViewController: UIViewController, ViewModelBindableType {

    var viewModel: SplashViewModel!

    @IBOutlet weak var btnKakao: UIButton!

    @IBOutlet weak var btnApple: UIButton!

    override func loadView() {
        super.loadView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindViewModel() {
        btnKakao.rx.action = viewModel.kakaoLoingAction()
    }

}
