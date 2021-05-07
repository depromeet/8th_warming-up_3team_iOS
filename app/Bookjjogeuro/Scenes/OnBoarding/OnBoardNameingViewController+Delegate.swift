//
//  OnBoardNameingViewController+Delegate.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/10.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

extension OnBoardNameingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setPlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            setPlaceholder()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let char = text.cString(using: .utf8) else { return false }
        guard let currentText = textView.text else { return false }
        guard let stringRange = Range(range, in: currentText) else { return false }
        let isBackSpace = strcmp(char, "\\b")
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        print("changedText:[\(changedText.count)] [\(changedText.lengthOfBytes(using: .utf16))]\(changedText)")
        print("changedText:[\(changedText.count)] [\(changedText.lengthOfBytes(using: .utf16))]\(changedText)")
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return changedText.count <= 8 || isBackSpace == -92
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
