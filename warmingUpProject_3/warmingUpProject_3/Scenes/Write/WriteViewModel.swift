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
import CoreLocation
import Firebase
import FirebaseDatabase
import GeoFire
import CodableFirebase

class WriteViewModel: BaseViewModel {
    
    var selColor = "NAVY"
    
    var selColorIndex: IndexPath = [0, 0]
    
    var selTimeIndex: IndexPath = [0, 0]
    
    var model: PostModel?
    
    let success = Observable.of(["NAVY","GRAY", "MINT", "PINK", "LEMON","BLUE","ORANGE","BROWN","GREEN","IVORY","PURPLE","RED","PEACH","BLACK"])
    
    let suggest = Observable.of(["촉촉한 새벽","새로운 아침", "나른한 낯 시간", "빛나는 오후", "별 헤는 밤"])
    
    let tag = Observable.of(["#따뜻한","#유쾌한", "#가벼운", "#무거운", "#묘한", "#몽환적인", "#쓸쓸한", "#강렬한", "#사랑스러운", "#희망적인", "#철학적인", "#여운", "#사색", "#재해석", "#명작"])
    
    
    let adderData = PublishSubject<[Any]>()
    
    let booksData = PublishSubject<[SearchBooks]>()
    
    let adderTitle = BehaviorSubject<String>(value: "")
    
    let bookTitle = BehaviorSubject<String>(value: "")
    
    override init(scenCoordinator: SceneCoordinatorType) {
        super.init(scenCoordinator: scenCoordinator)
        model = PostModel(title: "", colorType: "NAVY", lat: 0, log: 0, phrase: "", reason: "", time: "촉촉한 새벽", author: "", description: "", thumbnail: "", pubDate: "", publisher: "", tags: [], userID: 1, roadAddress: "", jibunAddress: "", addressElements: [])
    }
    
    override func getUid() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    func actionLocationView() {
        let writeViewModel = self
        let searchVC = Scene.search(writeViewModel)
        self.scenCoordinator.transition(to: searchVC, using: .push, animated: true)
    }
    
    func actionBookView() {
        let writeViewModel = self
        let searchVC = Scene.searchBook(writeViewModel)
        self.scenCoordinator.transition(to: searchVC, using: .push, animated: true)
    }
    
    func actionSave(completion: @escaping () -> Void) {
        guard let model = self.model else { return }
        
        self.provider.rx
            .request(.writeBook(model: model))
            .filterSuccessfulStatusCodes()
            .subscribe { (res) in
                print(res)
            } onError: { (err) in
                print(err)
            }
            .disposed(by: self.rx.disposeBag)

        /*
        let setWrite = FBWriteModel(title: model.title, colorType: model.colorType, latitude: model.lat, longitude: model.log, phrase: model.phrase, reason: model.reason, time: model.time, author: model.author, description: model.description, thumbnail: model.thumbnail, pubDate: model.pubDate, publisher: model.publisher, tags: model.tags, userID: FirebaseManager.getUID(), roadAddress: model.roadAddress, jibunAddress: model.jibunAddress)
        
        //TODO: model -> dict
        let docData = try! FirebaseEncoder().encode(setWrite)
//        print(docData)
        
        let autoIdKey = ref.childByAutoId().key ?? ""
        print("===== autoIdKey : ", autoIdKey)
        //TODO: geoFire.getLocationForKey("키")를 위해 uid 기준으로 저장한다.
//        let autoIdKey = getUid()
        
        // 1.위치를 geoFire를 이용하여 디비에 저장한다 - 업데이트 되버림
        // FIXME: autoIdKey 말고 뎁스를 하나 더 줄 수 없나?
        geoFire.setLocation(CLLocation(latitude: self.model?.lat ?? 0, longitude: self.model?.log ?? 0), forKey: autoIdKey) { [unowned self] _ in
            // 2. autoIdKey 기준으로 books에 데이터를 쌓는다.
            print(autoIdKey)
            // setValue
            self.ref.child("books").child(getUid()).child(autoIdKey).setValue(docData)
        }
    
        
        //TODO: - 해당 유저의 모든 북 리스트를 가져올 수 있음.
        self.ref.child("books").child(getUid()).observe(.value) { (snap) in
            print(snap)
        }
        
        
        print("===============")
    */
    }
}
