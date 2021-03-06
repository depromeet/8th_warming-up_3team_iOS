//
//  ReviewDetailModel.swift
//  warmingUpProject_3
//
//  Created by JieunKim on 2020/09/02.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class ReviewDetailModel: BaseViewModel {
    /*
    let selectedData = PublishSubject<[UInt]>()
    
    let times = Observable.of(["모든 시간", "촉촉한 새벽", "새로운 아침", "나른한 낮 시간", "빛나는 오후", "별 헤는 밤"])
    
    let writeData = BehaviorSubject<[BookList]>(value: [])
    
    let emptyData = PublishSubject<Bool>()
    
    func myPageAction() {
        let myPageViewModel = MyPageViewModel(scenCoordinator: self.scenCoordinator)
        let myPageScene = Scene.mypage(myPageViewModel)
        self.scenCoordinator.transition(to: myPageScene, using: .push, animated: true)
    }
    
    func writeAction() -> CocoaAction {
        return CocoaAction { _ in
            let writeViewModel = WriteViewModel(scenCoordinator: self.scenCoordinator)
            let writeScene = Scene.write(writeViewModel)
            return self.scenCoordinator.transition(to: writeScene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
    
    func requsTest() {
        
        geoCodeProvider.rx
            .request(.geocode(addr: "입장면"))
            .subscribe(onSuccess: { (res) in
                print(res)
            }) { (err) in
                print(err)
        }
    }
    
    func requestBooksList(lat: Double, log: Double) {
        provider.rx
            .request(.booksList(lat: lat, log: log))
            .filterSuccessfulStatusCodes()
            .map(BookListModel.self)
            .subscribe(onSuccess: { [unowned self] (res) in
                print(lat)
                print(log)
                if res.data?.isEmpty ?? true {
                    print(res.data?.isEmpty)
                    self.emptyData.onNext(true)
                } else {
                    self.writeData.onNext(res.data ?? [])
                }
            }) { (err) in
                print(err)
        }
        .disposed(by: rx.disposeBag)
    }*/
    
}
