//
//  BaseViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {

    let scenCoordinator: SceneCoordinatorType

    init(scenCoordinator: SceneCoordinatorType) {
        self.scenCoordinator = scenCoordinator
    }
}
