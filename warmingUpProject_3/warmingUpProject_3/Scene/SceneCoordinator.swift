//
//  SceneCoordinator.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    /*
     실제로 화면에 표시되어 있는 화면을 리턴하는 속성
     현재는 네비게이션컨트롤러만 고려함.
     탭바 컨트롤이나 다른 컨테이너 컨트롤러라면 해당에 맞게 수정해야함
     */
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {
    private let bag = DisposeBag()

    // 윈도우 인스턴스
    private let window: UIWindow

    // 현재 표시되고 있는
    private var currentVC: UIViewController

    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }

    @discardableResult
    func transition(to scene: Scene, using style: TransititionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        // 실제 생성자
        let target = scene.instantiate()

        switch style {
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()

        case .push:
            /*
             currentVC에 네비게이션컨트롤러가 찍힘
             Scene instantiate .list의 리턴 값은 nav
             */
            guard let nav = currentVC.navigationController else {
                // 네비에 임베드 되어 있지 않다면
                subject.onError(TransititionError.navigationControllerMissing)
                break
            }

            // 델리게이트 메소드가 호출되는 시점마다 Next이벤트를 방출하는 속성
            // UINavigationControllerDelegate.navigationController(_:willShow:animated:)
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] evt in
                    self.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: bag)

            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
            subject.onCompleted()

        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target.sceneViewController

        }

        // 서브젝트를 Completable 타입으로 바꿔줌
        return subject.ignoreElements()
    }

    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransititionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransititionError.unknown))
            }
            return Disposables.create()
        }
    }


}
