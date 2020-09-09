//
//  PostModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

public struct PostModel {
    
    var title: String
    var colorType: String
    var lat: Double
    var log: Double
    var phrase: String
    var reason: String
    var time: String
    var author: String
    var description: String
    var thumbnail: String
    var pubDate: String
    var publisher: String
    var tags: [String]
    var userID: Int
    var roadAddress: String
    var jibunAddress: String
    var addressElements: [AddressElement]
    
    init(title: String, colorType: String, lat: Double, log: Double, phrase: String, reason: String, time: String, author: String, description: String, thumbnail: String, pubDate: String, publisher: String, tags: [String], userID: Int, roadAddress: String, jibunAddress: String, addressElements: [AddressElement]  ) {
        
        self.title = title
        self.colorType = colorType
        self.lat = lat
        self.log = log
        self.phrase = phrase
        self.reason = reason
        self.time = time
        self.author = author
        self.description = description
        self.thumbnail = thumbnail
        self.pubDate = pubDate
        self.publisher = pubDate
        self.tags = tags
        self.userID = 1
        self.roadAddress = roadAddress
        self.jibunAddress = jibunAddress
        self.addressElements = addressElements
    }
}
