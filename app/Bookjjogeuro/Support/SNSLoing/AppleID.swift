//
//  AppleID.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/20.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import AuthenticationServices

@available(iOS 13.0, *)
class AppleID {
    static func login(controller: UIViewController) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        // 안먹힘
        // request.requestedOperation = .operationLogout
        // request.requestedOperation = .operationLogin

        let authController = ASAuthorizationController(authorizationRequests: [request])

        // ASAuthorizationControllerDelegate
        authController.delegate = controller as? ASAuthorizationControllerDelegate

        // 시스템이 사용자에게 권한 부여 인터페이스를 제시 할 수있는 표시 컨텍스트를 제공하는 대리자입니다.
        authController.presentationContextProvider = controller as? ASAuthorizationControllerPresentationContextProviding

        // 컨트롤러 초기화 중에 이름 지정된 권한 부여 플로우를 시작합니다.
        // 이걸 해야 뜨는데... 최초 애플 등록하고 나면....  "Apple Id 사용하여"가 노출... 설정 암호 및 보안에서 Apple ID 사용 중단을 해야함.
        authController.performRequests()
    }

    // 회원가입, 아이디 찾기로 핸드폰 인증 할 때, 로그아웃 액션을 해야하는데 애플 로그인은 없음.
    static func logout() { }

//    static func checkAuthorization(loginDelegate: SNSLoginDelegate, credential: ASAuthorizationAppleIDCredential) {
//        // Keychain Services - 써야할 듯! Certificate, Key, and Trust Services
//        // You shouldn't store user password / API Keys in UserDefaults for the same reason as well.
//        // 심사 반려 될 수도 있으니깐 데모에 따라
//
//        // 애플 로그인 최초 등록 || 애플 아이디 중단 후 로그인 시
//        // user : 디바이스 상관 없이 애플ID에 대한 고유값
//        // email, name 값은 최초 등록 시에만 내려 줌
//        // 로그아웃 오퍼레이터도 있으나, 동작 안함.
//        if let email = credential.email, credential.fullName != nil {
//            let name = (credential.fullName?.familyName ?? "") + (credential.fullName?.givenName ?? "")
//            do {
//                try KeyChainUtils(service: Bundle.main.bundleIdentifier ?? "com.amondz", account: Constants.KEYCHAIN_USER_IDENTIFIER_KEY).saveItem(credential.user)
//                try KeyChainUtils(service: Bundle.main.bundleIdentifier ?? "com.amondz", account: Constants.KEYCHAIN_EMAIL_KEY).saveItem(email)
//                try KeyChainUtils(service: Bundle.main.bundleIdentifier ?? "com.amondz", account: Constants.KEYCHAIN_NAME_KEY).saveItem(name)
//                UserUtils.setUserEmail(userKey: email)
//                UserUtils.setUserName(name: name)
//            } catch {
//                print("Unable to save userIdentifier to keychain.")
//            }
//        }
//            // 애플 최초 인증 X
//        else {
//            do {
//                let email = try KeyChainUtils(service: Bundle.main.bundleIdentifier ?? "com.amondz", account: Constants.KEYCHAIN_EMAIL_KEY).readItem()
//                let name = try KeyChainUtils(service: Bundle.main.bundleIdentifier ?? "com.amondz", account: Constants.KEYCHAIN_NAME_KEY).readItem()
//                UserUtils.setUserEmail(userKey: email)
//                UserUtils.setUserName(name: name)
//            } catch {
//                print("Unable to save userIdentifier to keychain.")
//            }
//        }
//
//        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: credential.user) { (state, error) in
//            switch state {
//            case .revoked:           // 지정된 사용자에 대한 권한이 취소되었습니다.
//                print("revoked")
//
//            case .authorized:        // 사용자에게 권한이 있습니다. || 재로그인 시
//                print("authorized")
//                // 인증 후 휴대폰 인증에서 뒤로가기 후 다시 애플 로그인하면 .notFound -> .authorized
//                // UserUtils.getUserId 제외하고 나머지가 "" 이면
//                // CodeGroup.LoginType.AppleID.rawValue
//                loginDelegate.onSucceed(id: credential.user, type: CodeGroup.LoginType.AppleID.rawValue, userName: UserUtils.getUserName(), userEmail: UserUtils.getUserEmail())
//
//            case .notFound:          // 사용자를 찾을 수 없습니다. || 애플 ID 서버에 최초 인증 시 (인증서 삭제 요청 현재 없음 2020.03.24)
//                let join = Join()
//                join.type = CodeGroup.LoginType.AppleID.rawValue
//                join.email = UserUtils.getUserEmail()
//                join.name = UserUtils.getUserName()
//                join.id = credential.user
//                loginDelegate.onNotFound(join: join)
//
//            case .transferred:       // 사용 가능한 개요가 없습니다.
//                print("transferred")
//
//            }
//        }
//    }
}
