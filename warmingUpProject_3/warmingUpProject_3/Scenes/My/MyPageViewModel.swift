//
//  MyPageViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MyPageViewModel: BaseViewModel {
    
    
    let bookList = PublishSubject<[UserBookList]>()
    
    func requestUserInfo(userID: Int) {
        provider.rx
            .request(.userBooksInfo(userID: userID))
            .filterSuccessfulStatusCodes()
            .map(UserModel.self)
            .subscribe(onSuccess: { [unowned self] res in
                self.bookList.onNext(res.data.rows ?? [])
            }) { (err) in
                print("err:    \(err)")
        }.disposed(by: rx.disposeBag)
    }
    
    
    
    
}
