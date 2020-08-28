//
//  GeocodeModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

// MARK: - GeocodeModel
class GeocodeModel: Codable {
    let status: String
    let meta: Meta
    let addresses: [Address]
    let errorMessage: String

    init(status: String, meta: Meta, addresses: [Address], errorMessage: String) {
        self.status = status
        self.meta = meta
        self.addresses = addresses
        self.errorMessage = errorMessage
    }
}

// MARK: - Address
class Address: Codable {
    let roadAddress, jibunAddress, englishAddress: String
    let addressElements: [AddressElement]
    let x, y: String
    let distance: Int

    init(roadAddress: String, jibunAddress: String, englishAddress: String, addressElements: [AddressElement], x: String, y: String, distance: Int) {
        self.roadAddress = roadAddress
        self.jibunAddress = jibunAddress
        self.englishAddress = englishAddress
        self.addressElements = addressElements
        self.x = x
        self.y = y
        self.distance = distance
    }
}

// MARK: - AddressElement
class AddressElement: Codable {
    let types: [String]
    let longName, shortName, code: String

    init(types: [String], longName: String, shortName: String, code: String) {
        self.types = types
        self.longName = longName
        self.shortName = shortName
        self.code = code
    }
}

// MARK: - Meta
class Meta: Codable {
    let totalCount, page, count: Int

    init(totalCount: Int, page: Int, count: Int) {
        self.totalCount = totalCount
        self.page = page
        self.count = count
    }
}
