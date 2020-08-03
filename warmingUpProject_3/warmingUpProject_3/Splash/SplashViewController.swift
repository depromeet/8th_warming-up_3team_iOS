//
//  SplashViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/03.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

final class SplashViewController: BaseViewController {

    override func loadView() {
        super.loadView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchOnBoarding(_ sender: Any) {
        let targetVC = OnBoardingViewController()
        targetVC.hidesBottomBarWhenPushed = true

        targetVC.modalPresentationStyle = .overFullScreen

        // iOS 13 이상 present 기본값: pageSheet
        self.present(targetVC, animated: false, completion: nil)
    }
}
