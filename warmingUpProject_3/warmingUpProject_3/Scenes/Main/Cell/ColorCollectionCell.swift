//
//  ColorCollectionCell.swift
//  warmingUpProject_3
//
//  Created by JieunKim on 2020/08/23.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class ColorCollectionCell: UICollectionViewCell {
    
    let lbRoundText: UILabel = {
       let lbRoundText = UILabel()
        lbRoundText.frame.size = CGSize(width: 30, height:30)
        
        lbRoundText.layer.cornerRadius =  lbRoundText.frame.size.width / 2
        
        lbRoundText.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        
        lbRoundText.backgroundColor = ColorUtils.colorTimeSelected
            lbRoundText.textColor =  ColorUtils.colorBlack
        return lbRoundText
    }()
    
//    override func draw(_ rect: CGRect) { //Your code should go here.
//        super.draw(rect)
//        self.layer.cornerRadius = self.frame.size.width / 2
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        layoutIfNeeded()
        setNeedsLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.contentView.frame.size = CGSize(width: 30, height:30)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.contentView.backgroundColor = .systemPink
        self.layer.borderColor = ColorUtils.color231.cgColor
        self.layer.borderWidth = 1
        self.addSubview(lbRoundText)
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        lbRoundText.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
        
    }
}
