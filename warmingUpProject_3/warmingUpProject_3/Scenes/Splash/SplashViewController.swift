//
//  SplashViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import Lottie

final class SplashViewController: UIViewController {
    
    @IBOutlet weak var lottieView: AnimationView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        /*
         SNS로 로그인 시 userID와 헤더가 들어와 이미 데이터가 있는 경우는 바로 메인으로
         그렇지 않은 경우는 로그인 화면으로 이동 처리해야함
         SNS 로그인이 불안정 함으로
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lottieView.play()
    }
    
    private func setUI() {
        self.view.backgroundColor = UIColor(r: 59, g: 66, b: 106)
        let splashAnimation = Animation.named("splash")
        lottieView.animation = splashAnimation
        lottieView.loopMode = .loop
    }
}
