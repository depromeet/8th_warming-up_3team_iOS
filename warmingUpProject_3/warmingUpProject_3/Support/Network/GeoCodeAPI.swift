//
//  GeoCodeAPI.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import Moya

public enum GeoCodeAPI {
    case geocode(addr: String)
}

//MARK: - TargetType, Moya에서 제공하는 프로토콜
extension GeoCodeAPI: TargetType {
    public var baseURL: URL {
        guard let host = URL(string: "https://naveropenapi.apigw.ntruss.com/map-geocode/v2") else { fatalError() }
        
        return host
    }
    
    public var path: String {
        switch self {
        case .geocode:
            return "/geocode"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .geocode:
            return .get
        }
    }
    
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        // URLEncoding.default
        switch self {
        case .geocode(let addr):
            return .requestParameters(parameters: ["query" : addr], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return [
            "X-NCP-APIGW-API-KEY-ID": "xm6p6sxsy2",
            "X-NCP-APIGW-API-KEY": "FnTENCYOMe9RBRVj7bJlIsEIPEG7vP7kYv4DXSeH"
            //            "authorization" : token
        ]
    }
    
    
    
}
