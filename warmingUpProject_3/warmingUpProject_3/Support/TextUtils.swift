//
//  TextUtils.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/04.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

class TextUtils {

    public enum FontType: String {
        case NanumMyeongjoRegular     = "NanumMyeongjo"
        case NanumMyeongjoBold      = "NanumMyeongjoBold"
    }

    static func textLetterSpacingAttribute(
        text: String,
        letterSpacing: CGFloat,
        color: UIColor?
    ) -> NSMutableAttributedString {
        let attrText = NSMutableAttributedString(string: text)
        attrText.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attrText.length))
        if let inputColor = color {
            attrText.addAttribute(.foregroundColor, value: inputColor, range: NSRange(location: 0, length: attrText.length))
        }
        return attrText
    }
    
    static func textLetterSpacingAttribute(
        text: String,
        letterSpacing: CGFloat,
        color: UIColor?,
        font: UIFont
    ) -> NSMutableAttributedString {
        let attrText = NSMutableAttributedString(string: text)
        attrText.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.font, value: font, range: NSRange(location: 0, length: attrText.length))
        if let inputColor = color {
            attrText.addAttribute(.foregroundColor, value: inputColor, range: NSRange(location: 0, length: attrText.length))
        }
        return attrText
    }

    static func attributedPlaceholder(text: String, letterSpacing: CGFloat) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
//        style.
        style.alignment = .center
        let attrText = NSMutableAttributedString(string: text)
        attrText.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.foregroundColor, value: ColorUtils.color170, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrText.length))
        return attrText
    }

}
