//
//  BookCoverView.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/19.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

class BookCoverView: UIView {
    
    let lbContent: EdgeInsetsLabel = {
        let lbContent = EdgeInsetsLabel(insets: .init(top: 15, left: 15, bottom: 15, right: 15))
        lbContent.backgroundColor = ColorUtils.colorCoverWhite
        lbContent.numberOfLines = 0
        lbContent.font = UIFont(name: TextUtils.FontType.NanumMyeongjoRegular.rawValue, size: 13)
        return lbContent
    }()
    
    let gra: CAGradientLayer = {
        let gra = CAGradientLayer()
        gra.colors = [
            UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        ]
        gra.type = .axial
        gra.startPoint = CGPoint(x: 0, y: 0.5)
        gra.endPoint = CGPoint(x: 1, y: 0.5)
        return gra
    }()
    
    /**
            다른 컴포넌트 내부에 들어가는 경우 그냥 초기화
     */
    init(colorChip: String = "", text: String = "") {
        super.init(frame: .zero)
        self.backgroundColor = ColorUtils.getColorChip(colorChip).bookColor
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowRadius = 4 / 2
        self.layer.shadowPath = nil
        self.layer.addSublayer(gra)
        self.addSubview(lbContent)
        
        self.lbContent.setTextWithLetterSpacing(text: text, letterSpacing: -0.06, lineHeight: 20)
        
        lbContent.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    /**
            다른 컴포넌트 내부에 들어가는 경우 바인드를 통해서 데이터 매핑
     */
    func bind(color: String, text: String) {
        self.backgroundColor = ColorUtils.getColorChip(color).bookColor
        self.lbContent.setTextWithLetterSpacing(text: text, letterSpacing: -0.06, lineHeight: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gra.frame = CGRect(x: self.frame.minX + 4, y: self.frame.minY, width: 16, height: self.frame.height)
    }
}
