//
//  adderCollectionCell.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class AdderCollectionCell: UICollectionViewCell {
    
    let lbText: UILabel = {
       let lbText = UILabel()
        lbText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lbText.textColor = ColorUtils.color34
        return lbText
    }()
    
    let lbSubText: UILabel = {
       let lbSubText = UILabel()
        lbSubText.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lbSubText.textColor = ColorUtils.color170
        return lbSubText
    }()
    
    let lbLine: UILabel = {
       let lbLine = UILabel()
        lbLine.backgroundColor = ColorUtils.color221
        return lbLine
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(lbText)
        self.addSubview(lbSubText)
        self.addSubview(lbLine)
        
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        lbText.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.width.equalTo(Dimens.deviceWidth - 20)
            make.height.equalTo(18)
        }
        
        lbSubText.snp.makeConstraints { (make) in
            make.top.equalTo(lbText.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.width.equalTo(Dimens.deviceWidth - 20)
            make.height.equalTo(14)
        }
        
        lbLine.snp.makeConstraints { (make) in
            make.top.equalTo(lbSubText.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(1)
            make.width.equalTo(Dimens.deviceWidth - 40)
            make.bottom.equalToSuperview()
        }
    }
}

