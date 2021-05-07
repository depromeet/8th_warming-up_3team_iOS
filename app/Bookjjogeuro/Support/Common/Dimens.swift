//
//  Dimens.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import UIKit

class Dimens {
    // MARK: 기기 사이즈
    static let deviceWidth: CGFloat = UIScreen.main.bounds.width
    
    static let deviceHeight: CGFloat = UIScreen.main.bounds.height

    static func getSafeAreaBottomMargin() -> CGFloat {
        var bottom: CGFloat = 0
        if #available(iOS 13.0, *) {
            bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0.0
        } else {
            bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        }

        return bottom
    }
}
