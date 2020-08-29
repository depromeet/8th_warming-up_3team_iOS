//
//  UserUtils.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/20.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

class UserUtils: NSObject {
    
    static let snsID: String              = "SNS_ID"
    
    static let snsType: String            = "SNS_TYPE"
    
    static let nickName: String           = "NickName"
    
    static let type: String               = "Type"
    
    static func removeAll() {
        UserDefaults.standard.removeObject(forKey: self.snsID)
        UserDefaults.standard.removeObject(forKey: self.snsType)
        UserDefaults.standard.removeObject(forKey: self.nickName)
        UserDefaults.standard.removeObject(forKey: self.type)
    }
    
    static func setSnsType(name: String) {
           UserDefaults.standard.set(name, forKey: self.snsType)
    }
    
    static func getSnsType() -> String {
        let snsType = UserDefaults.standard.value(forKey: self.snsType)
        return snsType as! String
    }
    
    static func setSnsID(Id: Int64) {
           UserDefaults.standard.set(Id, forKey: self.snsID)
    }
    
    static func getSnsID() -> Int64? {
        let snsID = UserDefaults.standard.value(forKey: self.snsID)
        return snsID as? Int64
    }
    
    static func setNickName(name: String) {
        UserDefaults.standard.set(name, forKey: self.nickName)
    }
    
    static func getNickName() -> String {
        let nickName = UserDefaults.standard.value(forKey: self.nickName)
        return nickName as! String
    }
    
    static func setType(type: Int) {
        UserDefaults.standard.set(type, forKey: self.type)
    }
    
    static func getType() -> Int {
        let type = UserDefaults.standard.value(forKey: self.type)
        return 1//type == nil ? 0 : type as! Int
    }
    
//    static func getNickName() -> String {
//        let nickName = UserDefaults.standard.value(forKey: self.nickName)
//        return nickName as! String
//    }
}
