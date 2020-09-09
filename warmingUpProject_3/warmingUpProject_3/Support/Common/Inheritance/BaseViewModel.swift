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
import FirebaseFirestore

class BaseViewModel: NSObject {

    let scenCoordinator: SceneCoordinatorType
    

    init(scenCoordinator: SceneCoordinatorType) {
        self.scenCoordinator = scenCoordinator
    }
    
    let db = Firestore.firestore()
    
    let provider = MoyaProvider<BookAPI>(plugins: [NetworkLoggerPlugin()])
    
    let geoCodeProvider = MoyaProvider<GeoCodeAPI>()
    
    let placeProvider = MoyaProvider<PlaceAPI>()
        
}
