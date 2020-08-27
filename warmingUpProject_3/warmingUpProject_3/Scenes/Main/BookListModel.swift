//
//  BookListModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

// MARK: - Welcome
class BookListModel: Decodable {
    let code: String
    let data: [BookList]?
}

// MARK: - DataClass
class BookList: Decodable {
    let id: Int
    let title, colorType: String
    let latitude, longitude: Double
    let phrase, reason, time, author: String
    let description, thumbnail, pubDate, publisher: String
    let userId: Int
    let createdAt, updatedAt: String
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, colorType, latitude, longitude, phrase, reason, time, author
        case description
        case thumbnail, pubDate, publisher
        case userId
        case createdAt, updatedAt, distance
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.colorType = try container.decode(String.self, forKey: .colorType)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.phrase = try container.decode(String.self, forKey: .phrase)
        self.reason = try container.decode(String.self, forKey: .reason)
        self.time = try container.decode(String.self, forKey: .time)
        self.author = try container.decode(String.self, forKey: .author)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.pubDate = try container.decode(String.self, forKey: .pubDate)
        self.publisher = try container.decode(String.self, forKey: .publisher)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.distance = try container.decode(Double.self, forKey: .distance)
    }
}
