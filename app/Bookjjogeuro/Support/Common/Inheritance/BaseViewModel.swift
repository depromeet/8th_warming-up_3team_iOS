//
//  BaseViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import FirebaseAuth

class BaseViewModel: NSObject {
    let scenCoordinator: SceneCoordinatorType
    
    init(scenCoordinator: SceneCoordinatorType) {
        self.scenCoordinator = scenCoordinator
    }
    
    let provider = MoyaProvider<BookAPI>(plugins: [NetworkLoggerPlugin()])
    
    let geoCodeProvider = MoyaProvider<GeoCodeAPI>(plugins: [NetworkLoggerPlugin()])
    
    let searchProvider = MoyaProvider<DaumSearchAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getUid() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
}
