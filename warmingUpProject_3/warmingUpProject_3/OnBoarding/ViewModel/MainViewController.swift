//
//  MainViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Action
// rx.disposeBag 사용하기
import NSObject_Rx
import NMapsMap

class MainViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MainViewModel!
    
    let mapView: UIView = {
        let naverMapView = NMFNaverMapView()
//        naverMapView.showLegalNotice()
        naverMapView.showLocationButton = true
//        locationOverlay.hidden = false
//        naverMapView.sho
        
        return naverMapView.mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func bindViewModel() {
        
    }
}

extension MainViewController {
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(mapView)
        
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        mapView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: NMFMapViewDelegate, CLLocationManagerDelegate {
    
}
