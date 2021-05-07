//
//  EdgeInsetsLabel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/20.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

class EdgeInsetsLabel: UILabel {
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    init(insets: UIEdgeInsets) {
        super.init(frame: .zero)
        self.insets = insets
    }
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
