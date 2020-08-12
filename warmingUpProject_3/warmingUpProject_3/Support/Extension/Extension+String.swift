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
}
