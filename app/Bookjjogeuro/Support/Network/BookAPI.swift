//
//  BookAPI.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import Moya

public enum BookAPI {
    // MARK: auth
    case signIn(snsType: String, snsID: String, snsToken: String)
    case signUp(nickName: String, type: Int, snsType: String, snsLoginID: String)
    // MARK: book
    case deleteBooks(id: Int) // delete
    case detailBook(id: Int) // get
    // 필요없음
    case searchBooks(title: String) // get
    case booksList(time: String, lat: Double, lng: Double, distance: Double)
    case writeBook(model: PostModel)
    case userBooksInfo(userID: Int)
    case test
}

// MARK: - TargetType, Moya에서 제공하는 프로토콜
extension BookAPI: TargetType {
    public var baseURL: URL {
//        guard let host = URL(string: "http://us-central1-bukjjogeuro.cloudfunctions.net/app") else { fatalError() }
        // http://118.34.36.148:5551/bukjjogeuro/us-central1/app
        guard let host = URL(string: "https://us-central1-bukjjogeuro.cloudfunctions.net/app") else { fatalError() }
        
        return host
    }
    
    public var path: String {
        switch self {
        case .signIn:
            return "/auth/sign-in"
        case .signUp:
            return "/auth/sign-up"
        case .deleteBooks:
            return "/books"
        case .detailBook(let id):
            return "/books?\(id)"
        case .searchBooks(let title):
            return "/books/search/\(title)"
        case .booksList:
            return "/getBookList"
        case .writeBook:
            return "/writeBook"
        case .userBooksInfo(let userID):
            return "/users/books/\(userID)"
        case .test:
            return "randomNumber"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .writeBook, .test, .booksList:
            return .post
        case .detailBook, .searchBooks, .userBooksInfo:
            return .get
        case .deleteBooks:
            return .delete
        }
    }
    
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        // URLEncoding.default
        switch self {
        case .signIn(let snsType, let snsID, let snsToken):
            return .requestParameters(
                parameters: [
                    "socialLoginType": snsType,
                    "socialLoginId": snsID,
                    "socialLoginToken": snsToken
                ],
                encoding: JSONEncoding.default)
            
        case .signUp(let nickName, let type, let snsType, let snsLoginID):
            return .requestParameters(
                parameters: [
                    "nickname": nickName,
                    "profileImageType": type,
                    "socialLoginType": snsType,
                    "socialLoginId": snsLoginID
                ],
                encoding: JSONEncoding.default)
            
            
        case .booksList(let time, let lat, let lng, let distance):
            return .requestParameters(
                parameters: [
                    "timeTag": time,
                    "latitude": lat,
                    "longitude": lng,
                    "distanceInKm": distance
                ],
                encoding: JSONEncoding.default
            )
            
        // MARK: book
        case .deleteBooks, .detailBook, .searchBooks, .userBooksInfo, .test:
            return .requestPlain
            
        case .writeBook(let model):
            return .requestParameters(
                parameters: [
                    "title": model.title,
                    "colorType": model.colorType,
                    "lat": model.lat,
                    "lng": model.log,
                    "phrase": model.phrase,
                    "reason": model.reason,
                    "time": model.time,
                    "author": model.author,
                    "description": model.description,
                    "thumbnail": model.thumbnail,
                    "pubDate": model.pubDate,
                    "publisher": model.publisher,
                    "tags": model.tags,
                    "userID": model.userID,
                    "roadAddress": model.roadAddress,
                    "jibunAddress": model.jibunAddress
                ],
                encoding: JSONEncoding.default)
            
        case .userBooksInfo(let userID):
            return .requestParameters(
                parameters: [
                    "": userID
                ],
                encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        let token = ""
        return [
            "content-Type": "application/json",
            "accept": "application/json"
//            "authorization" : token
        ]
    }
}
