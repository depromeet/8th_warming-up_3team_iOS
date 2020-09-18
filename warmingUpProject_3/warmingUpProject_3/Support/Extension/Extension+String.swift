//
//  Extension+String.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

extension String {

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {

        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    func nicknameCheck() -> Bool{
        do {
            let regex = try NSRegularExpression(pattern: "^[a-z|A-Z|가-힣|ㄱ-ㅎ|ㅏ-ㅣ|\\s]{1,7}$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func bookCoverCheck() -> Bool{
        do{
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\s]{0,32}$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)){
                return true
            }
        }catch{
            print(error.localizedDescription)
            return false
        }
        return false
    }
}
