//
//  Scene.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

enum Scene {
    case splash
    case login(LoginViewModel)
    case onboardNamming(OnBoardNameingViewModel)
    case onboardType(OnBoardTypeViewModel)
    case onboardExplanation(OnBoardExplanationViewModel)
    case main(MainViewModel)
    case write(WriteViewModel)
    case search(WriteViewModel)
    case searchBook(WriteViewModel)
    case mypage(MyPageViewModel)
    case reviewDetail(ReviewDetailModel)
}

// 스토리 보드에 있는 씬을 생성 연관값이 저장된 뷰 모델을 바인딩해서 리턴
extension Scene {
    func instantiate(from storyboard: String = Constants.MAIN) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .splash:
            guard let splashVC = storyboard.instantiateViewController(withIdentifier: "splashVC") as? SplashViewController else { fatalError() }
            return splashVC
            
        case .login(let viewModel):
            guard var loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController else { fatalError() }
            loginVC.bind(viewModel: viewModel)
            return loginVC
            
        case .onboardNamming(let viewModel):
            var onBoardNameingVC = OnBoardNameingViewController()
            onBoardNameingVC.bind(viewModel: viewModel)
            return onBoardNameingVC
            
        case .onboardType(let viewModel):
            var onBoardTypeVC = OnBoardTypeViewController()
            onBoardTypeVC.bind(viewModel: viewModel)
            return onBoardTypeVC
            
        case .onboardExplanation(let viewModel):
            var onBoardExplanationVC = OnBoardExplanationViewController()
            onBoardExplanationVC.bind(viewModel: viewModel)
            return onBoardExplanationVC
            
        case .main(let viewModel):
            let naviVC = UINavigationController()
            naviVC.isNavigationBarHidden = true
            var mainVC = MainViewController()
            mainVC.bind(viewModel: viewModel)
            naviVC.setViewControllers([mainVC], animated: false)
            return naviVC
            
        case .write(let viewModel):
            let naviVC = UINavigationController()
            naviVC.isNavigationBarHidden = true
            var writeVC = WriteViewController()
            writeVC.bind(viewModel: viewModel)
            naviVC.setViewControllers([writeVC], animated: false)
            return writeVC
            
        case .search(let viewModel):
            var searchVC = SearchLocaitonViewController()
            searchVC.bind(viewModel: viewModel)
            return searchVC
            
        case .searchBook(let viewModel):
            var searchVC = SearchBookViewController()
            searchVC.bind(viewModel: viewModel)
            return searchVC
            
        case .mypage(let viewModel):
            var mypageVC = MyPageViewController()
            mypageVC.bind(viewModel: viewModel)
            return mypageVC
            
        case .reviewDetail(let viewModel):
        var detailVC = HomeReviewDetailViewController()
        detailVC.bind(viewModel: viewModel)
        return detailVC
        }
    }
}

