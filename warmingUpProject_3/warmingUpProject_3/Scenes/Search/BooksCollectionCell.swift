//
//  BooksCollectionCell.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class BooksCollectionCell: UICollectionViewCell {
    
    let basrViwe = UIView()
    
    let ivImageView: UIImageView = {
        let ivImageView = UIImageView()
        return ivImageView
    }()
    
    let lbTitle: UILabel = {
       let lbTitle = UILabel()
        return lbTitle
    }()
    
    let lbSubText: UILabel = {
       let lbSubText = UILabel()
        lbSubText.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lbSubText.textColor = ColorUtils.color170
        return lbSubText
    }()
    
    let lbDescription: UILabel = {
       let lbDescription = UILabel()
        return lbDescription
    }()
    
    let lbSeparLine: UILabel = {
        let lbSeparLine = UILabel()
        lbSeparLine.backgroundColor = ColorUtils.color242
        return lbSeparLine
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
        self.addSubview(basrViwe)
        self.addSubview(ivImageView)
        self.addSubview(lbTitle)
        self.addSubview(lbSubText)
        self.addSubview(lbDescription)
        self.addSubview(lbSeparLine)
        
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        basrViwe.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(Dimens.deviceWidth)
            make.height.equalTo(103)
        }
        
        ivImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(35)
            make.width.equalTo(46)
            make.height.equalTo(60)
        }
        
        lbTitle.snp.makeConstraints { (make) in
            make.top.equalTo(ivImageView.snp.top)
            make.leading.equalTo(ivImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-34)
            make.height.equalTo(19)
        }
        
        lbSubText.snp.makeConstraints { (make) in
            make.top.equalTo(lbTitle.snp.bottom).offset(6)
            make.leading.equalTo(lbTitle.snp.leading)
            make.trailing.equalTo(lbTitle.snp.trailing)
            make.height.equalTo(13)
        }
        
        lbDescription.snp.makeConstraints { (make) in
            make.top.equalTo(lbSubText.snp.bottom).offset(8)
            make.leading.equalTo(lbTitle.snp.leading)
            make.trailing.equalTo(lbTitle.snp.trailing)
            make.height.equalTo(14)
            make.bottom.equalToSuperview().offset(-19)
        }
        
        lbSeparLine.snp.makeConstraints { (make) in
            make.top.equalTo(ivImageView.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}

