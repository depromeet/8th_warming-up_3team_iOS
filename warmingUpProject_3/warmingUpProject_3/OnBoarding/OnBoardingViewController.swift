//
//  OnBoardingViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/03.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

class OnBoardingViewController: BaseViewController {

    override func loadView() {
        super.loadView()
        setUI()
    }

    override func viewDidLoad() {
        print("######### OnBoardingViewController ")
    }

    private func setUI() {
        self.view.backgroundColor = .white
    }
}

