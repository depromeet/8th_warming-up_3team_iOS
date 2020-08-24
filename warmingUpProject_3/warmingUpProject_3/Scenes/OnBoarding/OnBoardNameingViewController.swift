//
//  OnBoardingViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/03.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import Action
import NSObject_Rx
import KakaoSDKUser

class OnBoardNameingViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: OnBoardNameingViewModel!
    
    let ivQuotes: UIImageView = {
        let ivQuotes = UIImageView()
        ivQuotes.image = UIImage(named: "icnDoubleQuotes")
        
        return ivQuotes
    }()
    
    let lbTitle: UILabel = {
        let lbTitle = UILabel()
        lbTitle.numberOfLines = 0
        lbTitle.font = UIFont(name: TextUtils.FontType.NanumMyeongjoRegular.rawValue, size: 20)
        lbTitle.setTextWithLetterSpacing(text: "북쪽으로와 함께할\n닉네임을 입력해주세요.", letterSpacing: -0.1, lineHeight: 30)
        lbTitle.textAlignment = .center
        return lbTitle
    }()
    
    let ivTextfieldLeft: UIImageView = {
        let ivTextfieldLeft = UIImageView()
        ivTextfieldLeft.image = UIImage(named: "icnTextfieldLeft")
        return ivTextfieldLeft
    }()
    
    let tvNickName: UITextView = {
        let tfNickName = UITextView()
        return tfNickName
    }()
    
    let ivTextfieldRight: UIImageView = {
        let ivTextfieldRight = UIImageView()
        ivTextfieldRight.image = UIImage(named: "icnTextfieldRight")
        return ivTextfieldRight
    }()
    
    let lbWarningMessage: UILabel = {
        let lbWarningMessage = UILabel()
        lbWarningMessage.font = UIFont.systemFont(ofSize: 12)
        lbWarningMessage.textColor = .lightGray
        lbWarningMessage.textAlignment = .center
        lbWarningMessage.attributedText = TextUtils.textLetterSpacingAttribute(text: "이후 수정이 불가하니 신중히 선택해주세요.", letterSpacing: -0.06, color: nil)
        return lbWarningMessage
    }()
    
    var btnNext: UIButton = {
        let btnNext = UIButton(type: .custom)
        btnNext.isEnabled = false
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
        
        UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
            if let error = error {
                print(error)
            }
            else {
                print("accessTokenInfo() success.")
                
                //do something
                _ = accessTokenInfo
            }
        }
        
    }
    
    func bindViewModel() {
        btnNext.rx.action = viewModel?.nextAction()
    }
    
}

//MARK: private 메소드
extension OnBoardNameingViewController {
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(ivQuotes)
        self.view.addSubview(lbTitle)
        self.view.addSubview(ivTextfieldLeft)
        self.view.addSubview(tvNickName)
        self.view.addSubview(ivTextfieldRight)
        self.view.addSubview(btnNext)
        self.view.addSubview(lbWarningMessage)
        
        tvNickName.delegate = self
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
        setPlaceholder()
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
        
        ivTextfieldLeft.snp.makeConstraints { (make) in
            make.top.equalTo(lbTitle.snp.bottom).offset(95)
            make.leading.equalToSuperview().offset(55)
            make.height.equalTo(60)
            make.width.equalTo(20)
        }
        
        tvNickName.snp.makeConstraints { (make) in
            make.leading.equalTo(ivTextfieldLeft.snp.leading).offset(25)
            make.trailing.equalTo(ivTextfieldRight.snp.leading).offset(-25)
            make.centerY.equalTo(ivTextfieldLeft.snp.centerY)
            make.height.equalTo(24)
        }
        
        ivTextfieldRight.snp.makeConstraints { (make) in
            make.top.equalTo(ivTextfieldLeft.snp.top)
            make.bottom.equalTo(ivTextfieldLeft.snp.bottom)
            make.trailing.equalToSuperview().offset(-55)
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
        
        lbWarningMessage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.bottom.equalTo(btnNext.snp.top).offset(-32)
        }
    }
    
    func setPlaceholder() {
        if tvNickName.text == "최대 8자까지 입력 가능합니다." {
            
            tvNickName.text = ""
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            tvNickName.typingAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .semibold),
            NSAttributedString.Key.foregroundColor : ColorUtils.color68,
            NSAttributedString.Key.paragraphStyle: style
            ]
            
        } else if tvNickName.text == "" || tvNickName.text.isEmpty {
            
            tvNickName.font = UIFont.systemFont(ofSize: 14)
            tvNickName.attributedText = TextUtils.attributedPlaceholder(text: "최대 8자까지 입력 가능합니다.", letterSpacing: -0.07)
        }
    }
}

extension OnBoardNameingViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setPlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            setPlaceholder()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        
        return newLength <= 8
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
