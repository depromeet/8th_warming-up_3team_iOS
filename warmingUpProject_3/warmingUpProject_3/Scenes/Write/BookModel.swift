//
//  BooksModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

struct BooksModel: Codable {
    let documents: [SearchBooks]?
    let meta: BookMeta?
    
}

struct SearchBooks: Codable {
    let authors: [String]?
    let contents, datetime, isbn: String?
    let price: Int?
    let publisher: String?
    let salePrice: Int?
    let status: String?
    let thumbnail: String?
    let title: String?
    let translators: [String]?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, translators, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        authors = try container.decode([String].self, forKey: .authors)
        contents = try container.decode(String.self, forKey: .contents)
        datetime = try container.decode(String.self, forKey: .datetime)
        isbn = try container.decode(String.self, forKey: .isbn)
        price = try container.decode(Int.self, forKey: .price)
        publisher = try container.decode(String.self, forKey: .publisher)
        salePrice = try container.decode(Int.self, forKey: .salePrice)
        status = try container.decode(String.self, forKey: .status)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        title = try container.decode(String.self, forKey: .title)
        translators = try container.decode([String].self, forKey: .translators)
        url = try container.decode(String.self, forKey: .url)
    }
}

struct BookMeta: Codable {
    let isEnd: Bool?
    let pageableCount, totalCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnd = try container.decode(Bool.self, forKey: .isEnd)
        pageableCount = try container.decode(Int.self, forKey: .pageableCount)
        totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
    }
}
