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
import FirebaseAuth
import NSObject_Rx
import Lottie

final class LoginViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: LoginViewModel!
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
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
        
        btnApple.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [unowned self]_ in
                self.performSignIn()
            })
            .disposed(by: rx.disposeBag)
        
    }
    
    // 버튼 액션
    func performSignIn() {
        let request = createAppleIdRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func createAppleIdRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
}

// MARK: 인증 콜백 처리
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { [unowned self] (authResult, error) in
                if let user = authResult?.user {
                    print("Nice! You're now signed in as \(user.uid), email: \(user.email)")
                    
                    
                    //TODO: 저장하는 부분
                    let setUser = FBUserModel(uID: user.uid,
                                              nickName: "",
                                              type: 0,
                                              email: user.email)
                    
                    
                    FirebaseManager.setUser(data: setUser) {
                        self.viewModel.appleLoingSucceed()
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
}

// MARK: 프레젠테이션 컨텍스트 처리
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}



// MARK: - 파이어베이스 처리용
// SecRandomCopyBytes(_:_:_)를 사용하여 암호로 보호된 nonce를 생성하는 메소드
private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}


import CryptoKit

// Unhashed nonce.
fileprivate var currentNonce: String?

@available(iOS 13, *)
private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()
    
    return hashString
}
