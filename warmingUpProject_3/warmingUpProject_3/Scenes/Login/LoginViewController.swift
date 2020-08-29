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
import Lottie

final class LoginViewController: UIViewController, ViewModelBindableType {

    var viewModel: LoginViewModel!

    @IBOutlet weak var btnKakao: UIButton!

    @IBOutlet weak var btnApple: UIButton!
    
    @IBOutlet weak var lottieView: AnimationView!
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        btnApple.layer.cornerRadius = 6
        btnKakao.layer.cornerRadius = 6
        let loginAnimation = Animation.named("login")
        lottieView.animation = loginAnimation
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func bindViewModel() {
        
//        btnKakao.rx.action = viewModel.kakaoLoingAction()
        btnKakao.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [unowned self]_ in
                self.viewModel.kakaoLoingAction()
            })
            .disposed(by: rx.disposeBag)
        btnApple.rx.action = viewModel.mainAction()
            
    }

}


@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {

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
