//
//  OnBoardingViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/03.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class OnBoardNameingViewController: BaseViewController {

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

    let tfNickName: UITextField = {
        let tfNickName = UITextField()
        // 사이즈 별로 자동으로 됨 19 전까지는 SF Pro Text
        tfNickName.font = UIFont.systemFont(ofSize: 14)
        print("------tfNickName.font: \(tfNickName.font)")
//        tfNickName.placeholder = "최대 8자까지 입력 가능합니다."
        tfNickName.attributedPlaceholder = TextUtils.attributedPlaceholder(text: "최대 8자까지 입력 가능합니다.", letterSpacing: -0.07)
        return tfNickName
    }()

    let ivTextfieldRight: UIImageView = {
        let ivTextfieldRight = UIImageView()
        ivTextfieldRight.image = UIImage(named: "icnTextfieldRight")
        return ivTextfieldRight
    }()


    override func loadView() {
        super.loadView()
        setUI()
    }

    override func viewDidLoad() {
        print("######### OnBoardingViewController ")
    }

}

//MARK: private 메소드
extension OnBoardNameingViewController {

    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(ivQuotes)
        self.view.addSubview(lbTitle)
        self.view.addSubview(ivTextfieldLeft)
        self.view.addSubview(tfNickName)
        self.view.addSubview(ivTextfieldRight)
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
    }

    private func setLayout() {
        ivQuotes.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(52)//offset(52)
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

        tfNickName.snp.makeConstraints { (make) in
            make.top.equalTo(ivTextfieldLeft).offset(21)
            make.leading.equalTo(ivTextfieldLeft.snp.trailing).offset(23)
            make.height.equalTo(17)
            make.width.equalTo(179)
        }

        ivTextfieldRight.snp.makeConstraints { (make) in
            make.top.equalTo(ivTextfieldLeft.snp.top)
            make.leading.equalTo(tfNickName.snp.trailing).offset(23)
            make.trailing.equalToSuperview().offset(-55)
        }
    }
}
