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
    
    @IBOutlet weak var tt: AnimationView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tt.play()
    }
    
    private func setUI() {
        self.view.backgroundColor = UIColor(r: 59, g: 66, b: 106)
        let splashAnimation = Animation.named("splash")
        tt.animation = splashAnimation
        tt.loopMode = .loop
    }
}
