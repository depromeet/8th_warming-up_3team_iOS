//
//  SingUpModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/07.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

// MARK: - Welcome
class SingUpModel: Decodable {
    let code: String
    let timestamp: String
    let message: String?
    let data: AccessToken
}

// MARK: - DataClass
class AccessToken: Decodable {
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.accessToken = try? container.decode(String.self, forKey: .accessToken)
    }
}
