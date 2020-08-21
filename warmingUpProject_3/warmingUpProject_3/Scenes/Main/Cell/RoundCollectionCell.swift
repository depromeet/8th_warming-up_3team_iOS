//
//  RoundCollectionCell.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/20.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class RoundCollectionCell: UICollectionViewCell {
    
    let lbRoundText: UILabel = {
       let lbRoundText = UILabel()
        lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lbRoundText.textColor = ColorUtils.color68
        return lbRoundText
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
        self.layer.cornerRadius = 17
        self.layer.borderColor = ColorUtils.color231.cgColor
        self.layer.borderWidth = 1
        self.addSubview(lbRoundText)
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        lbRoundText.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.greaterThanOrEqualTo(20).priority(999)
            make.bottom.equalToSuperview().offset(-7)
        }
        
    }
}

