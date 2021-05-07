//
//  MainViewModel.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import NMapsMap

class MainViewModel: BaseViewModel {
    var beforeCameraPosition: NMFCameraPosition?
    
    let selectedData = PublishSubject<[[AnyHashable: Any]]>()
    
    let times = Observable.of(["모든 시간", "촉촉한 새벽", "새로운 아침", "나른한 낮 시간", "빛나는 오후", "별 헤는 밤"])
    
    var selTime: IndexPath = [0, 0]
    
    let writeData = BehaviorSubject<[CLLocation]>(value: [])
    // <[QueryDocumentSnapshot]>(value: [])
    
    let emptyData = PublishSubject<Bool>()
    
    var markers: [NMFMarker] = []
    
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
    
    func getUserInfo(completion: @escaping (FBUserModel?) -> Void) {
//        let docRef = db.collection("users").document(FirebaseManager.getUID())
//        docRef.getDocument { (doc, err) in
//            guard let doc = doc else { return }
//            
//            do {
//                let user = try doc.data(as: FBUserModel.self)
//                completion(user)
//            } catch let error {
//                print("Error writing city to Firestore: \(error)")
//            }
//        }
    }
    
    // 주변 아이템 가져오기
    func getDocumentNearBy(latitude: Double, longitude: Double, distance: Double) {
        provider.rx
            .request(.booksList(time: "모든 시간", lat: latitude, lng: longitude, distance: distance))
            .filterSuccessfulStatusCodes()
            .map(BookListModel.self)
            .subscribe(onSuccess: { [unowned self] (res) in
//                print(lat)
//                print(log)
                if res.data?.isEmpty ?? true {
                    print(res.data?.isEmpty)
                    self.emptyData.onNext(true)
                } else {
//                    self.writeData.onNext(res.data ?? [])
                }
            }) { (err) in
                print(err)
        }
        .disposed(by: rx.disposeBag)
        
        
//        let writeRef = Firestore.firestore().collection("writeBook")
//        
        
//        let docRef = Firestore.firestore().collection("writeBook")
//            .whereField("location", isGreaterThan: lesserGeopoint)
//            .whereField("location", isLessThan: greaterGeopoint)
//        GeoFire.query(<#T##self: GeoFire##GeoFire#>)
//        docRef.getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                if snapshot!.documents.count == 0 {
//                    self.emptyData.onNext(true)
//                } else {
//                    do {
//                        let before = try self.writeData.value()
//
//                        // 첫번째 요청
//                        if before.count == 0 {
//                            self.writeData.onNext(snapshot!.documents)
//                        }
//                            // 두번째 요청
//                        else {
//                            var nextValue = before
//
//                            // 새로운 데이터가 이전 데이터와 다를 때만 추가
//                            for val in snapshot!.documents {
//                                let isSame = nextValue.contains(val)
//
//                                if !isSame {
//                                    nextValue.append(val)
//                                }
//                            }
//
//                            self.writeData.onNext(nextValue)
//                        }
//
//                    } catch {
//
//                    }
//                }
//            }
//        }
        
    }
    
    func getTimeDocumentNearBy(time: String, latitude: Double, longitude: Double, distance: Double) {
        provider.rx
            .request(.booksList(time: time, lat: latitude, lng: longitude, distance: distance))
            .filterSuccessfulStatusCodes()
            .map(BookListModel.self)
            .subscribe(onSuccess: { [unowned self] (res) in
//                print(lat)
//                print(log)
                if res.data?.isEmpty ?? true {
                    print(res.data?.isEmpty)
                    self.emptyData.onNext(true)
                } else {
//                    self.writeData.onNext(res.data ?? [])
                }
            }) { (err) in
                print(err)
        }
        .disposed(by: rx.disposeBag)
        
//        let aa = geoFire.query(at: CLLocation(latitude: 36.9204863, longitude: 127.2154336), withRadius: 1)
        // TODO: 서울시티타워 기준
//        let aa = geoFire.query(at: CLLocation(latitude: 37.5543418, longitude: 126.972316), withRadius: 1)
//            //.observe(.keyEntered) { (s, loc) in
//        var value = [CLLocation]()
//        aa.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
//            print("Key= '\(key)', \nlocation= '\(location)'")
//            value.append(location)
////            self.writeData.onNext(nextValue)
//            print("=================")
//            print("======= 보여지는 ==========")
//            print(value)
//            print("=================")
//            self.writeData.onNext(value)
//        })
//
        // ~1 mile of lat and lon in degrees
//        let lat = 0.0144927536231884
//        let lon = 0.0181818181818182
//
//        let lowerLat = latitude - (lat * distance)
//        let lowerLon = longitude - (lon * distance)
//
//        let greaterLat = latitude + (lat * distance)
//        let greaterLon = longitude + (lon * distance)
//
//        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
//        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)
//
//        let docRef = Firestore.firestore().collection("writeBook")
//            .whereField("location", isGreaterThan: lesserGeopoint)
//            .whereField("location", isLessThan: greaterGeopoint)
//        //TODO: 왜 안되냐 복합 쿼리..
////            .whereField("time", isEqualTo: time)
//
//        docRef.getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                if snapshot!.documents.count == 0 {
//                    self.emptyData.onNext(true)
//                } else {
//                    do {
//                        let before = try self.writeData.value()
//
//                        // 첫번째 요청
//                        if before.count == 0 {
//                            var nextValue = [QueryDocumentSnapshot]()
//                            for val in snapshot!.documents {
//                                let target = try val.data(as: FBWriteModel.self)
//                                if time == "모든 시간" {
//                                    nextValue.append(val)
//                                } else if target?.time == time {
//                                    nextValue.append(val)
//                                }
//                            }
//                            self.writeData.onNext(nextValue)
//                        }
//                            // 두번째 요청
//                        else {
//                            var nextValue = before
//
//                            // 새로운 데이터가 이전 데이터와 다를 때만 추가
//                            for val in snapshot!.documents {
//                                let target = try val.data(as: FBWriteModel.self)
//                                let isSame = nextValue.contains(val)
//
//                                if !isSame {
//                                    if time == "모든 시간" {
//                                        nextValue.append(val)
//                                    } else if target?.time == time {
//                                        nextValue.append(val)
//                                    }
//                                }
//                            }
//
//                            self.writeData.onNext(nextValue)
//                        }
//
//                    } catch {
//
//                    }
//                }
//            }
//        }
//
    }
}
