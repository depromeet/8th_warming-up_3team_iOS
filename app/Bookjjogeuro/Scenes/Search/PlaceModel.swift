//
//  PlaceModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/09.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

class PlaceModel: Codable {
    let documents: [Document]

    init(documents: [Document]) {
        self.documents = documents
    }
}

// MARK: - Document
class Document: Codable {
    let addressName, categoryGroupCode, categoryGroupName, categoryName: String
    let distance, id, phone, placeName: String
    let placeURL: String
    let roadAddressName, x, y: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case categoryName = "category_name"
        case distance, id, phone
        case placeName = "place_name"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case x, y
    }

    init(addressName: String, categoryGroupCode: String, categoryGroupName: String, categoryName: String, distance: String, id: String, phone: String, placeName: String, placeURL: String, roadAddressName: String, x: String, y: String) {
        self.addressName = addressName
        self.categoryGroupCode = categoryGroupCode
        self.categoryGroupName = categoryGroupName
        self.categoryName = categoryName
        self.distance = distance
        self.id = id
        self.phone = phone
        self.placeName = placeName
        self.placeURL = placeURL
        self.roadAddressName = roadAddressName
        self.x = x
        self.y = y
    }
}
