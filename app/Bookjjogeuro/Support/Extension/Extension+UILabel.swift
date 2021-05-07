//
//  extensionUILabel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/06.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

extension UILabel {
    func setTextWithLetterSpacing(text: String, letterSpacing: CGFloat, lineHeight: CGFloat) {
        let style = NSMutableParagraphStyle()
        let attrText = NSMutableAttributedString(string: text)
        style.alignment = self.textAlignment
        style.lineSpacing = lineHeight - self.font.lineHeight
        attrText.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrText.length))
        self.attributedText = attrText
    }
    
    func setTextWithLetterSpacing(text: String, letterSpacing: CGFloat, lineHeight: CGFloat, font: UIFont, color: UIColor) {
        let style = NSMutableParagraphStyle()
        let attrText = NSMutableAttributedString(string: text)
        style.alignment = self.textAlignment
        style.lineSpacing = lineHeight - font.lineHeight
        attrText.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.font, value: font, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: attrText.length))
        self.attributedText = attrText
    }

    func setFocusTextWithLetterSpacing(text: String, focusText: String, focusFont: UIFont, focusColor: UIColor, letterSpacing: CGFloat, lineHeight: CGFloat, color: UIColor) {
        let style = NSMutableParagraphStyle()
        let attrText = NSMutableAttributedString(string: text)
        style.lineSpacing = lineHeight - self.font.lineHeight
        attrText.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: attrText.length))


        // Focus 처리
        let nsRange = (attrText.string as NSString).range(of: focusText)
        attrText.addAttribute(.font, value: focusFont, range: nsRange)
        attrText.addAttribute(.foregroundColor, value: focusColor, range: nsRange)

        self.attributedText = attrText
    }
}
