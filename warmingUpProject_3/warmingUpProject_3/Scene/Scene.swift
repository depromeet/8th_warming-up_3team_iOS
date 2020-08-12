//
//  Scene.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

enum Scene {
    case splash(SplashViewModel)
    case onboardNamming(OnBoardNameingViewModel)
    case onboardType(OnBoardTypeViewModel)
    case onboardExplanation(OnBoardExplanationViewModel)
    case main(MainViewModel)
}

// 스토리 보드에 있는 씬을 생성 연관값이 저장된 뷰 모델을 바인딩해서 리턴
extension Scene {
    func instantiate(from storyboard: String = Constants.MAIN) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .splash(let viewModel):
            guard var splashVC = storyboard.instantiateViewController(identifier: "splashVC") as? SplashViewController else { fatalError() }
            splashVC.bind(viewModel: viewModel)
            return splashVC
            
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
            var mainVC = MainViewController()
            mainVC.bind(viewModel: viewModel)
            return mainVC
        }
    }
}

