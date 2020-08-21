//
//  BookCoverCollectionCell.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/18.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class BookCoverCollectionCell: UICollectionViewCell {
    
    let bookCover = BookCoverView()
    
    let bgBookTitle: UIView = {
        let bgBookTitle = UIView()
        return bgBookTitle
    }()
    
    let lbBookTitle: UILabel = {
        let lbBookTitle = UILabel()
        lbBookTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbBookTitle.textColor = ColorUtils.color34
        lbBookTitle.numberOfLines = 0
        return lbBookTitle
    }()
    
    let lbWriter: UILabel = {
        let lbWriter = UILabel()
        lbWriter.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        lbWriter.textColor = ColorUtils.color136
        lbWriter.numberOfLines = 0
        return lbWriter
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
        self.addSubview(bookCover)
        self.addSubview(bgBookTitle)
        self.addSubview(lbBookTitle)
        self.addSubview(lbWriter)
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        bookCover.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bgBookTitle.snp.top).offset(-20)
            make.bottom.equalTo(lbBookTitle.snp.top).offset(-20)
        }
        
        bgBookTitle.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(36)
            make.bottom.equalTo(lbWriter.snp.top).offset(-6)
        }
        
        lbBookTitle.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-6).priority(999)
        }
        
        lbWriter.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(14)
            make.bottom.equalToSuperview().offset(-(Dimens.getSafeAreaBottomMargin() + 22))
        }
    }
}

