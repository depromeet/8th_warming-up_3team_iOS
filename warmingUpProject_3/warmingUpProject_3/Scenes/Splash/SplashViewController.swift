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
import AuthenticationServices
import NSObject_Rx

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
        btnApple.rx.action = viewModel.mainAction()
//        btnApple.rx.action = viewModel.appleLoingAction()
        
//         btnApple.rx
//                   .controlEvent(.touchUpInside)
//                   .subscribe(onNext: { [weak self] _ in
//                       guard let self = self else { return }
//                    AppleID.login(controller: self)
//                   })
//            .disposed(by: rx.disposeBag)
    }

}


extension SplashViewController: ASAuthorizationControllerDelegate {

    // error 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("\n\n  error   :   \(error)  \n\n")
    }

    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        // 애플 인증 후 항시 들어오는 애플 아이디에 대한 고유 값
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        print(222)
        print(111)
//        AppleID.checkAuthorization(loginDelegate: self, credential: credential)
    }
}
