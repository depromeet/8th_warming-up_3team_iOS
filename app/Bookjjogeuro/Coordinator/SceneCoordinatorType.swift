//
//  SceneCoordinatorType.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    // Completable == Observable<Void>, 완료만 필요할때
    @discardableResult
    func transition(to scene: Scene, using styple: TransititionStyle, animated: Bool) -> Completable

    @discardableResult
    func close(animated: Bool) -> Completable
}
