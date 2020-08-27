//
//  UserModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

// MARK: - Welcome
class UserModel: Decodable {
    let code: String
    let data: UserData
}

// MARK: - DataClass
class UserData: Decodable {
    let count: Int
    let rows: [UserBookList]?
}

class UserBookList: Decodable {
    
    let id: Int
    let title, colorType, phrase, author: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title, colorType, phrase, author
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.colorType = try container.decode(String.self, forKey: .colorType)
        self.phrase = try container.decode(String.self, forKey: .phrase)
        self.author = try container.decode(String.self, forKey: .author)
        
    }
}
