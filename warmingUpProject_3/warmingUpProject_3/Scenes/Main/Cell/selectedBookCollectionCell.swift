//
//  selectedBookCollectionCell.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/22.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class selectedBookCollectionCell: UICollectionViewCell {
    
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
        lbWriter.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbWriter.textColor = ColorUtils.color136
        lbWriter.numberOfLines = 0
        return lbWriter
    }()
    
    let lbBookSummary: UILabel = {
        let lbBookSummary = UILabel()
        lbBookSummary.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        lbBookSummary.textColor = ColorUtils.color68
        lbBookSummary.numberOfLines = 3
        return lbBookSummary
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
        self.addSubview(lbBookSummary)
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        bookCover.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(130)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        lbBookTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(bookCover.snp.trailing).offset(24)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(38)
        }
        
        lbWriter.snp.makeConstraints { (make) in
            make.top.equalTo(lbBookTitle.snp.bottom).offset(8)
            make.leading.equalTo(lbBookTitle.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(17)
        }
        
        lbBookSummary.snp.makeConstraints { (make) in
            make.top.equalTo(lbWriter.snp.bottom).offset(16)
            make.leading.equalTo(lbBookTitle.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
    }
}

