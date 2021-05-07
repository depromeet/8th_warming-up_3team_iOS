//
//  HeaderCollectionCell.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class HeaderCollectionCell: UICollectionReusableView {
    let tt = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        addSubview(tt)
        tt.frame = self.frame
        tt.backgroundColor = .yellow
        self.backgroundColor = .red
//        addSubview(lineView)
//        lineView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            lineView.heightAnchor.constraint(equalToConstant: SearchDimens.SEPARATE_VIEW_HEIGHT),
//            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SearchDimens.HORIZONTAL_MARGIN),
//            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SearchDimens.HORIZONTAL_MARGIN),
//            lineView.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
    }
}
