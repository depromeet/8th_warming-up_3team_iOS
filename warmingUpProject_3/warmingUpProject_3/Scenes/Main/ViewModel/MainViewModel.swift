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

class MainViewModel: BaseViewModel {
    
    let writeData = Observable.of([
        (location: (lat: 36.920218, lng: 127.215237), color: "NAVY", content: "바람이 불었다. 다만 나에게 주어진 길을 묵묵히 걸어가고자 했다.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.920218, lng: 127.215237), color: "GRAY", content: "내래 연변에서 온 간나.", book: "오늘부터의 세계", write: "김초엽"),
        (location: (lat: 36.920218, lng: 127.215237), color: "MINT", content: "후루루루루룩 국수먹고 먹고목.", book: "작은 동네", write: "김초엽"),
        (location: (lat: 36.920753, lng: 127.215588), color: "PINK", content: "외딴 섬의 기록.", book: "큰 동네", write: "김초엽"),
        (location: (lat: 36.920487, lng: 127.218308), color: "LEMON", content: "세상 모든 사람들이 당신에게서 등으로 돌리고.", book: "오늘부터의 세계", write: "김초엽"),
        (location: (lat: 36.921619, lng: 127.216270), color: "BLUE", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.914114, lng: 127.215981), color: "ORANGE", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.913946, lng: 127.215970), color: "BROWN", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.915388, lng: 127.215482), color: "GREEN", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.915422, lng: 127.217311), color: "IVORY", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.917915, lng: 127.214793), color: "PURPLE", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.918481, lng: 127.218102), color: "RED", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.921433, lng: 127.218544), color: "PEACH", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽"),
        (location: (lat: 36.923456, lng: 127.225331), color: "BLACK", content: "외딴 섬의 기록.", book: "우리가 빛의 속도로 갈수 없다면", write: "김초엽")
    ])
    
    let times = Observable.of(["하루 종일", "촉촉한 새벽", "새로운 아침", "나른한 낮 시간", "별 헤는 밤"])
    
    
    
    func writeAction() -> CocoaAction {
        return CocoaAction { _ in
            let writeViewModel = WriteViewModel(scenCoordinator: self.scenCoordinator)
            let writeScene = Scene.write(writeViewModel)
            return self.scenCoordinator.transition(to: writeScene, using: .modal, animated: true).asObservable().map { _ in }
        }
    }
    
}
