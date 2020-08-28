//
//  BooksModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

// MARK: - Welcome
class BooksModel: Decodable {
    let code: String
    let timestamp: String
    let message: String?
    let data: [SearchBooks]
}

// MARK: - DataClass
class SearchBooks: Decodable {
    let title: String
    let image: String
    let author: String
    let publisher: String
    let pubDate: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case title, image, author, publisher, pubDate, description
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.image = try container.decode(String.self, forKey: .image)
        self.author = try container.decode(String.self, forKey: .author)
        self.publisher = try container.decode(String.self, forKey: .publisher)
        self.pubDate = try container.decode(String.self, forKey: .pubDate)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
