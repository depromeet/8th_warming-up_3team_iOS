//
//  emptyCollectionCell.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class EmptyView: UIView {
    let lbEmpty: UILabel = {
        let lbEmpty = UILabel()
        lbEmpty.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbEmpty.setTextWithLetterSpacing(text: "앗! 근처에 책이 없어요 ㅜ.ㅠ", letterSpacing: -0.08, lineHeight: 16, font: .systemFont(ofSize: 16, weight: .medium), color: ColorUtils.color170)
        return lbEmpty
    }()
    
    let ivImage: UIImageView = {
        let ivImage = UIImageView()
        ivImage.image = #imageLiteral(resourceName: "imgEmpty")
        return ivImage
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
        self.addSubview(lbEmpty)
        self.addSubview(ivImage)
        // TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        lbEmpty.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(34)
            make.leading.equalToSuperview().offset(96 - 20)
            make.height.equalTo(19)
        }
        
        ivImage.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(73)
        make.leading.equalToSuperview().offset(72)
        make.height.equalTo(165)
        }
    }
}

