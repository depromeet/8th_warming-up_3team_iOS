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
    
    func requestTest() {
        provider.rx
            .request(.test)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [unowned self] res in
                print(res.data)
                /*
                 ▿ 1 bytes
                 - count : 1
                 ▿ pointer : 0x000000016d7a08c0
                 - pointerValue : 6131681472
                 ▿ bytes : 1 element
                 - 0 : 51
                 
                 */
            }) { (err) in
                print(err)
            }
            .disposed(by: rx.disposeBag)
    }
}
