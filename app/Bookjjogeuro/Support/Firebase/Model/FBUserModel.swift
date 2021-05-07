//
//  FBUserModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/08.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

public struct FBUserModel: Codable {
    let uID: String
    let nickName: String
    let type: Int
    let email: String?

    enum CodingKeys: String, CodingKey {
        case uID
        case nickName
        case type
        case email
    }
}
