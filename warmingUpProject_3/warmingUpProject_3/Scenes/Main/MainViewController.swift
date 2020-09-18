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
import NSObject_Rx
import NMapsMap

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        // MARK: 현재 위치 설정 - 매니저로 뺴야하는데
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager?.location?.coordinate.latitude ?? 37.5666102, lng: locationManager?.location?.coordinate.longitude ?? 126.9783881))
        cameraUpdate.pivot = CGPoint(x: 0.5, y: 0.3)
        mapView.moveCamera(cameraUpdate)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: baseView.frame.height, right: 0)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getTimeDocumentNearBy(time: "모든 시간", latitude: locationManager?.location?.coordinate.latitude ?? 37.5666102, longitude: locationManager?.location?.coordinate.longitude ?? 126.9783881, distance: 1) // 10 == 16km, 5 == 8km, 2.5 == 4km, 23
    }
    
    
    @objc func tapProfile() {
        viewModel.myPageAction()
    }
    
    // MARK: Properties
    var viewModel: MainViewModel!
    
    var locationManager: CLLocationManager?
    
    let naverMapView = NMFNaverMapView()
    
    var mapView: NMFMapView {
        let locationOverlay = naverMapView.mapView.locationOverlay
        locationOverlay.circleOutlineWidth = 50
        locationOverlay.circleColor = UIColor.blue
        locationOverlay.hidden = false
        locationOverlay.icon = NMFOverlayImage(name: "imgLocationDirection", in: Bundle.naverMapFramework())
        locationOverlay.subIcon = nil
        
        naverMapView.mapView.touchDelegate = self
        naverMapView.mapView.addCameraDelegate(delegate: self)
        naverMapView.showScaleBar = true

        return naverMapView.mapView
    }
    
    let profileBaseView: UIView = {
        let profileView = UIView()
        profileView.backgroundColor = .white
        profileView.layer.cornerRadius = 23
        
        return profileView
    }()
    
    let profileTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 19
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let lbNickName: UILabel = {
        let lbTitle = UILabel()
        lbTitle.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        lbTitle.textAlignment = .center
        
        return lbTitle
    }()
    
    let baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = .white
        //FIXME: 임의로 한 값 - 제플린에 정확히 수치 나오면 적용해야함.
        baseView.layer.cornerRadius = 15
        baseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        baseView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        baseView.layer.shadowOpacity = 1
        baseView.layer.shadowOffset = CGSize(width: 0, height: -2)
        baseView.layer.shadowRadius = 8 / 2
        
        return baseView
    }()
    
    let timeListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 10, height: 34)
        layout.scrollDirection = .horizontal
        let timeListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        timeListCollectionView.contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 12, right: 60)
        timeListCollectionView.backgroundColor = .white
        timeListCollectionView.showsHorizontalScrollIndicator = false
        timeListCollectionView.register(RoundCollectionCell.self, forCellWithReuseIdentifier: String(describing: RoundCollectionCell.self))
        return timeListCollectionView
    }()
    
    let separateLine: UIView = {
        let separateLine = UIView()
        separateLine.frame.size = CGSize(width: Dimens.deviceWidth, height: 1)
        separateLine.backgroundColor = ColorUtils.color242
        return separateLine
    }()
    
    let bookListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 130, height: 168 + 132)
        layout.scrollDirection = .horizontal
        let bookListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bookListCollectionView.contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
        bookListCollectionView.backgroundColor = .white
        bookListCollectionView.showsHorizontalScrollIndicator = false
        bookListCollectionView.register(BookCoverCollectionCell.self, forCellWithReuseIdentifier: String(describing: BookCoverCollectionCell.self))
        return bookListCollectionView
    }()
    
    let selectedBaseView: UIView = {
        let selectedBaseView = UIView()
        selectedBaseView.backgroundColor = .white
        selectedBaseView.layer.cornerRadius = 12
        selectedBaseView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        selectedBaseView.layer.shadowOpacity = 1
        selectedBaseView.layer.shadowOffset = CGSize(width: 0, height: 6)
        selectedBaseView.layer.shadowRadius = 20 / 2
        selectedBaseView.isHidden = true
        
        return selectedBaseView
    }()
    
    let selectedSeparateLine: UIView = {
        let separateLine = UIView()
        separateLine.frame.size = CGSize(width: Dimens.deviceWidth, height: 1)
        separateLine.backgroundColor = ColorUtils.color242
        return separateLine
    }()
    
    let lbSelecteTime: UILabel = {
        let selecteTime = UILabel()
        selecteTime.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        selecteTime.textColor = ColorUtils.color34
        return selecteTime
    }()
    
    let ivLocation: UIImageView = {
        let ivLocation = UIImageView(image: #imageLiteral(resourceName: "icnPin16"))
        return ivLocation
    }()
    
    let lbSelecteLocation: UILabel = {
        let lbSelecteLocation = UILabel()
        lbSelecteLocation.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbSelecteLocation.textColor = UIColor(r: 84, g: 90, b: 124)
        return lbSelecteLocation
    }()
    
    let selectedBookListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: Dimens.deviceWidth - 80, height: 168 )
        layout.scrollDirection = .horizontal
        let bookListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bookListCollectionView.isPagingEnabled = true
        bookListCollectionView.backgroundColor = .white
        bookListCollectionView.showsHorizontalScrollIndicator = false
        bookListCollectionView.register(selectedBookCollectionCell.self, forCellWithReuseIdentifier: String(describing: selectedBookCollectionCell.self))
        return bookListCollectionView
    }()
    
    let btnCurrentLocation: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.setImage(#imageLiteral(resourceName: "icnLocation24"), for: .normal)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    // ------
    var btnWrite: UIButton = {
        let btnWrite = UIButton(type: .custom)
        btnWrite.backgroundColor = .white
        btnWrite.setImage(#imageLiteral(resourceName: "icnWrite"), for: .normal)
        btnWrite.layer.masksToBounds = false
        btnWrite.layer.cornerRadius = 29
        btnWrite.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        btnWrite.layer.shadowOpacity = 1
        btnWrite.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnWrite.layer.shadowRadius = 4 / 2
        
        let layer1 = CALayer()
        layer1.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer1.shadowOpacity = 1
        layer1.shadowOffset = CGSize(width: 0, height: 4)
        layer1.shadowRadius = 10 / 4
        
        btnWrite.layer.insertSublayer(layer1, at: 1)
        
        return btnWrite
    }()
}
