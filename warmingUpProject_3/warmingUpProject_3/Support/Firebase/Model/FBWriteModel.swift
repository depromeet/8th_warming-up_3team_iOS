//
//  FBWriteModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/09.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import CoreLocation

public struct FBWriteModel: Codable {
    
    let title: String
    let colorType: String
    let latitude: Double
    let longitude: Double
    let phrase: String
    let reason: String
    let time: String
    let author: String
    let description: String
    let thumbnail: String
    let pubDate: String
    let publisher: String
    let tags: [String]
    let userID: String
    var roadAddress: String?
    var jibunAddress: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case colorType
        case latitude
        case longitude
        case phrase
        case reason
        case time
        case author
        case description
        case thumbnail
        case pubDate
        case publisher
        case tags
        case userID
        case roadAddress
        case jibunAddress
    }
    
}

