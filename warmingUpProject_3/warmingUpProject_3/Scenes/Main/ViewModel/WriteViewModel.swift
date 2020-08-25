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
    let success = Observable.of(["가","나", "다", "라", "마","바","사","아","자","차","카","타","파","하"])
}
