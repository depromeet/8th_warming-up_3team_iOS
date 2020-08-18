//
//  BaseViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/03.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import RxSwift

open class BaseViewController<T>: UIViewController {

    open var disposeBag = DisposeBag()

    open var viewModel: T?

    deinit {
        print("## deinit ##")
        disposeBag = DisposeBag()
    }
}
