//
//  OnBoardExplanationViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import Action

class OnBoardExplanationViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: OnBoardExplanationViewModel!
    
    let ivQuotes: UIImageView = {
        let ivQuotes = UIImageView()
        ivQuotes.image = UIImage(named: "icnDoubleQuotes")
        
        return ivQuotes
    }()
    
    let lbTitle: UILabel = {
        let lbTitle = UILabel()
        lbTitle.numberOfLines = 0
        lbTitle.font = UIFont(name: TextUtils.FontType.NanumMyeongjoRegular.rawValue, size: 20)
        lbTitle.setTextWithLetterSpacing(text: "기능은 세줄이 아닌 두줄로만 설명하기 최대 두줄로 제한함", letterSpacing: -0.1, lineHeight: 30)
        lbTitle.textAlignment = .center
        return lbTitle
    }()
    
    var btnNext: UIButton = {
        let btnNext = UIButton(type: .custom)
        btnNext.setTitle("다음", for: .normal)
        btnNext.setTitle("다음", for: .selected)
        btnNext.setTitleColor(.white, for: .normal)
        btnNext.setTitleColor(.white, for: .selected)
        btnNext.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        btnNext.titleEdgeInsets.top = -Dimens.getSafeAreaBottomMargin() - 17
        btnNext.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btnNext.titleLabel?.attributedText = TextUtils.attributedPlaceholder(text: "다음", letterSpacing: -0.09)
        return btnNext
    }()
    
    override func loadView() {
        super.loadView()
        setUI()
    }
    
    override func viewDidLoad() {
        print("######### OnBoardingViewController ")
    }
    
    func bindViewModel() {
        btnNext.rx.action = viewModel?.nextAction()
    }
    
}

//MARK: private 메소드
extension OnBoardExplanationViewController {
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(ivQuotes)
        self.view.addSubview(lbTitle)
        self.view.addSubview(btnNext)
        
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        ivQuotes.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(52)
            make.centerX.equalToSuperview().offset(-1)
            make.height.equalTo(24)
            make.width.equalTo(30)
        }
        
        lbTitle.snp.makeConstraints { (make) in
            make.top.equalTo(ivQuotes.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(90)
        }
        
        
        btnNext.snp.makeConstraints { (make) in
            var bottom: CGFloat = 0
            if #available(iOS 13.0, *) {
                bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0.0
            } else {
                bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
            }
            print(bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(74 + Dimens.getSafeAreaBottomMargin())
            make.bottom.equalToSuperview()
        }
    }
}
