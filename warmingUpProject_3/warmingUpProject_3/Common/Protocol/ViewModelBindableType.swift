//
//  ViewModelBindableType.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

protocol ViewModelBindableType {

    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    // self.viewModel가 수정 됨으로 mutating 선언해줘야함
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        // loadView() -> loadViewIfNeeded() -> viewDidLoad()
        // TODO: 이걸 호출하는 이유가 뭐지?!
        loadViewIfNeeded()

        bindViewModel()
    }
}

