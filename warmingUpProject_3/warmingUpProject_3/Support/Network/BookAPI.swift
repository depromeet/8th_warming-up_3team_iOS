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
    
    case searchBooks(title: String) // get
    
    case booksList(lat: Double, log: Double)
    
    //TODO: 입력 모델 만들기
    case writeBook(
        title: String, colorType: String, lat: CGFloat, lon: CGFloat, phrase: String, reason: String,
        time: String, author: String, description: String, thumbnail: String, pubDate: String, publisher: String,
        tag: [String], userID: Int
    )
    
    case userBooksInfo(userID: Int)
    
}

//MARK: - TargetType, Moya에서 제공하는 프로토콜
extension BookAPI: TargetType {
    public var baseURL: URL {
        guard let host = URL(string: "http://3.34.96.70:5000") else { fatalError() }
        
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
            return "/books/search?\(title)"
        case .booksList:
            return "/books"
        case .writeBook:
            return "/books"
        case .userBooksInfo(let userID):
            return "/users/books/\(userID)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .writeBook:
            return .post
        case .detailBook, .searchBooks, .booksList, .userBooksInfo:
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
                    "socialLoginType" : snsType,
                    "socialLoginId" : snsID,
                    "socialLoginToken" : snsToken
                ],
                encoding: JSONEncoding.default)
            
        case .signUp(let nickName, let type, let snsType, let snsLoginID):
            return .requestParameters(
                parameters: [
                    "nickname" : nickName,
                    "profileImageType" : type,
                    "socialLoginType" : snsType,
                    "socialLoginId" : snsLoginID
                ],
                encoding: JSONEncoding.default)
            
            
        case .booksList(let lat, let log):
            
            return .requestParameters(parameters: ["latitude" : lat, "longitude" : log], encoding: URLEncoding.queryString)
            
        // MARK: book
        case .deleteBooks, .detailBook, .searchBooks, .userBooksInfo:
            return .requestPlain
            
        //TODO: 입력 모델 만들기
        case .writeBook(
            let title, let colorType, let lat, let log, let phrase, let reason,
            let time, let author, let description, let thumbnail, let pubDate, let publisher,
            let tags, let userID
            ):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "colorType": colorType,
                    "latitude": lat,
                    "longitude": log,
                    "phrase": phrase,
                    "reason": reason,
                    "time": time,
                    "author": author,
                    "description": description,
                    "thumbnail": thumbnail,
                    "pubDate": pubDate,
                    "publisher": publisher,
                    "tags": tags,
                    "userId": userID

                ],
                encoding: JSONEncoding.default)
            
        case .userBooksInfo(let userID):
            return .requestParameters(
                parameters: [
                    "" : userID,
                ],
                encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        let token = ""
        return [
            "content-Type": "application/json",
            "accept": "application/json"
//            "authorization" : token
        ]
    }
    
    
    
}
