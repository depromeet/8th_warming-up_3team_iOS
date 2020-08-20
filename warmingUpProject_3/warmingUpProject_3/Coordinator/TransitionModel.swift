//
//  TransitionModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation

// 전환 방식을 표현하는
enum TransititionStyle {
    case root
    case push
    case modal
}

// 전환 시 에러
enum TransititionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}

