//
//  PlaceAPI.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/09.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import Moya

public enum PlaceAPI {
    case place(addr: String)
}

//MARK: - TargetType, Moya에서 제공하는 프로토콜
extension PlaceAPI: TargetType {
    
    public var baseURL: URL {
        guard let host = URL(string: "https://dapi.kakao.com/v2/local/search") else { fatalError() }
        
        return host
    }
    
    public var path: String {
        switch self {
        case .place:
            return "/keyword.json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .place:
            return .get
        }
    }
    
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        // URLEncoding.default
        switch self {
        case .place(let addr):
            return .requestParameters(
                parameters: [
                    "format": "json",
                    "query" : addr
                ]
                , encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Authorization" : "KakaoAK 8b0b1493ed48a588677ad601420dd704"]
    }
    
}
