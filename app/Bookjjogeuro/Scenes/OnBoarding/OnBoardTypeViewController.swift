//
//  OnBoardTypeViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class OnBoardTypeViewController: UIViewController {
    var viewModel: OnBoardTypeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: Propertice
    let ivQuotes: UIImageView = {
        let ivQuotes = UIImageView()
        ivQuotes.image = UIImage(named: "icnDoubleQuotes")
        
        return ivQuotes
    }()
    
    let lbTitle: UILabel = {
        let lbTitle = UILabel()
        lbTitle.numberOfLines = 0
        lbTitle.textColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        lbTitle.font = UIFont(name: TextUtils.FontType.NanumMyeongjoRegular.rawValue, size: 20)
        
        lbTitle.textAlignment = .center
        return lbTitle
    }()
    
    let profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 84, height: 106)
        layout.scrollDirection = .vertical
        let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        profileCollectionView.backgroundColor = .clear
        profileCollectionView.register(ProfileCollectionCell.self, forCellWithReuseIdentifier: String(describing: ProfileCollectionCell.self))
        return profileCollectionView
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
}

extension OnBoardTypeViewController {
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(ivQuotes)
        self.view.addSubview(lbTitle)
        self.view.addSubview(profileCollectionView)
        self.view.addSubview(btnNext)
        self.view.addSubview(lbWarningMessage)
        // TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
        
        lbTitle.setFocusTextWithLetterSpacing(text: "\(viewModel.nickName)님의\n독서 유형에 맞는\n프로필사진을 골라주세요.", focusText: viewModel.nickName, focusFont: UIFont(name: TextUtils.FontType.NanumMyeongjoBold.rawValue, size: 20) ?? UIFont.systemFont(ofSize: 20), focusColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), letterSpacing: -0.1, lineHeight: 30, color: ColorUtils.color34)
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
        
        lbWarningMessage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(14)
            make.bottom.equalTo(btnNext.snp.top).offset(-32)
        }
        
        profileCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(lbTitle.snp.bottom).offset(57)
            make.leading.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().offset(-49)
            make.height.equalTo(220)
            make.bottom.lessThanOrEqualTo(lbWarningMessage.snp.top).offset(-142).priority(999)
        }
    }
}
