//
//  FirebaseManager.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/08.
//  Copyright © 2020 team3. All rights reserved.
//

import Firebase
import FirebaseAuth

class FirebaseManager {
    
    static func setUser(data: FBUserModel, completion: @escaping () -> Void) {
//        let db = Firestore.firestore()
//        do {
//            try db.collection("users").document(data.uID).setData(from: data)
//
//            completion()
//        } catch let error {
//            print("Error writing city to Firestore: \(error)")
//        }
    }
    
    static func setWrite(data: FBWriteModel, completion: @escaping () -> Void) {
//        let db = Firestore.firestore()
//        do {
//            try db.collection("writeBook").addDocument(from: data)
//
//            completion()
//        } catch let error {
//            print("Error writing city to Firestore: \(error)")
//        }
    }
    
    static func getUID() -> String {
        guard let user = Auth.auth().currentUser else { return "" }
        return user.uid
    }
}
