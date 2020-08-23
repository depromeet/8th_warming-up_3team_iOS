//
//  WriteViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/18.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class WriteViewModel: BaseViewModel {
    let success = Observable.of(["성공하렴","촉촉한 새벽", "새로운 아침", "나른한 낮 시간", "별 헤는 밤"])
}
