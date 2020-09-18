//
//  BaseViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxSwift
import Moya
import FirebaseDatabase
import FirebaseAuth
import GeoFire

class BaseViewModel: NSObject {

    let scenCoordinator: SceneCoordinatorType
    
    init(scenCoordinator: SceneCoordinatorType) {
        self.scenCoordinator = scenCoordinator
        
    }
    
    let ref = Database.database().reference()
    
    lazy var geoFire: GeoFire = {
        let geoFire = GeoFire(firebaseRef: ref)
        return geoFire
    }()
    
    let provider = MoyaProvider<BookAPI>(plugins: [NetworkLoggerPlugin()])
    
    let geoCodeProvider = MoyaProvider<GeoCodeAPI>()
    
    let placeProvider = MoyaProvider<PlaceAPI>()
    
    func getUid() -> String {
        
        return Auth.auth().currentUser?.uid ?? ""
    }
        
}
