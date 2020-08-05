//
//  extensionUILabel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/06.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

extension UILabel {

    func setTextWithLetterSpacing(text: String?, letterSpacing: CGFloat, lineHeight: CGFloat) {
        if text != nil && !text!.isEmpty {
            let style = NSMutableParagraphStyle()
            let attrText = NSMutableAttributedString(string: text ?? "")
            style.lineSpacing = lineHeight - self.font.lineHeight
            print("------- style.lineSpacing: \(style.lineSpacing), lineHeight: \(lineHeight) || font.lineHeight: \(self.font.lineHeight)")
            attrText.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attrText.length))
            attrText.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrText.length))
            self.attributedText = attrText
        }
    }
}
