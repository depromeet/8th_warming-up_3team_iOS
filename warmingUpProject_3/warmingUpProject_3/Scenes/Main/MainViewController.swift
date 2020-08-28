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
import CoreLocation

class MainViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MainViewModel!
    
    var locationManager: CLLocationManager?
    
    let naverMapView = NMFNaverMapView()
    
    var markers: [NMFMarker] = [NMFMarker(position: NMGLatLng(lat: 37.5666102, lng: 126.9783881))]
    
    var mapView: NMFMapView {
        let locationOverlay = naverMapView.mapView.locationOverlay
        locationOverlay.circleOutlineWidth = 50
        locationOverlay.circleColor = UIColor.blue
        locationOverlay.hidden = false
        locationOverlay.icon = NMFOverlayImage(name: "imgLocationDirection", in: Bundle.naverMapFramework())
        locationOverlay.subIcon = nil
        
        naverMapView.mapView.touchDelegate = self
        return naverMapView.mapView
    }
    
    let profileBaseView: UIView = {
        let profileView = UIView()
        profileView.backgroundColor = .white
        profileView.layer.cornerRadius = 23
        
        let imageView = UIImageView()
        switch UserUtils.getType() {
        case 0:
            imageView.image = UIImage(named: "img28Profile1")
            
        case 1:
            imageView.image = UIImage(named: "img28Profile2")
            
        case 2:
            imageView.image = UIImage(named: "img28Profile3")
            
        case 3:
            imageView.image = UIImage(named: "img28Profile4")
            
        case 4:
            imageView.image = UIImage(named: "img28Profile5")
            
        case 5:
            imageView.image = UIImage(named: "img28Profile6")
            
        default:
            break
        }
        
        imageView.layer.cornerRadius = 19
        imageView.layer.masksToBounds = true
        
        let lbTitle = UILabel()
        lbTitle.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        lbTitle.textAlignment = .center
        lbTitle.setTextWithLetterSpacing(text: UserUtils.getNickName(), letterSpacing: -0.06, lineHeight: 16)
        profileView.addSubview(imageView)
        profileView.addSubview(lbTitle)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.leading.equalTo(4)
            make.width.equalTo(38)
            make.bottom.equalTo(-4)
        }
        
        lbTitle.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.leading.equalTo(imageView.snp.trailing).offset(9)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-15)
        }
        
        return profileView
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
    
    
    // --------------
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: baseView.frame.height, right: 0)
        
        
    }
    
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
        
        lbSelecteTime.setTextWithLetterSpacing(text: "나른한 낮 시간", letterSpacing: -0.08, lineHeight: 19)
        lbSelecteLocation.setTextWithLetterSpacing(text: "망원동, 아틀리에 크레타", letterSpacing: -0.07, lineHeight: 17)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.requesBooksList(lat: locationManager?.location?.coordinate.latitude ?? 37.5666102, log: locationManager?.location?.coordinate.longitude ?? 126.9783881)
        
    }
    
    @objc func tapProfile() {
        viewModel.myPageAction()
    }
    
    func bindViewModel() {
        btnWrite.rx.action = viewModel.writeAction()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapProfile))
        profileBaseView.addGestureRecognizer(tap)
        
        //FIXME: 현재 위치 동작안함 이벤트가 왜 안걸리지?!
        btnCurrentLocation.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { _ in
                print(1232131)
            })
            .disposed(by: rx.disposeBag)
        
        
        viewModel.writeData
            .subscribe(onNext: { [unowned self ] value in
                
                // 다 지우고
                self.markers.forEach { $0.mapView = nil }
                
                // 한방에 들어오네
                for (idx, value) in value.enumerated() {
                    self.markers.append(NMFMarker(position: NMGLatLng(lat: value.latitude, lng: value.longitude)))
                    self.markers[idx].iconImage = NMFOverlayImage(image: ImageUtils.getColorBookIcon(value.colorType))
                    self.markers[idx].mapView = self.naverMapView.mapView
                    self.markers[idx].tag = UInt(value.id)
                    //                    self.markers[idx].isHideCollidedMarkers = true
                    //                    self.markers[idx].isHideCollidedCaptions = true
                }
            })
            .disposed(by: rx.disposeBag)
        
        /*
         // 네이버 지도에서 선택된 마커가 들어오는 경우 처리
         viewModel.selectedData
         .subscribe(onNext: { [unowned self]values in
         print("------ value:    \(values)")
         
         // 애니메이션 줘야함
         if values.isEmpty || values == [] {
         self.baseView.isHidden = false
         self.btnWrite.isHidden = false
         self.selectedBaseView.isHidden = true
         } else {
         self.baseView.isHidden = true
         self.btnWrite.isHidden = true
         self.selectedBaseView.isHidden = false
         }
         
         })
         .disposed(by: rx.disposeBag)
         */
//
//            .bind(to: bookListCollectionView.rx.items(cellIdentifier: String(describing: EmptyCollectionCell.self), cellType: EmptyCollectionCell.self)) { (row, element, cell) in
//                print(1)
//            }.disposed(by: rx.disposeBag)
        
        
        viewModel.writeData
            .do(onNext: { bookList in
                if bookList.isEmpty {
                    self.bookListCollectionView.addSubview(EmptyView())
                } else {
                    for subView in self.bookListCollectionView.subviews {
                        if subView is EmptyView {
                            subView.removeFromSuperview()
                        }
                    }
                }
            })
            .bind(to: bookListCollectionView.rx.items(cellIdentifier: String(describing: BookCoverCollectionCell.self), cellType: BookCoverCollectionCell.self)) { (row, element, cell) in
                print(element)
                
                cell.bookCover.bind(color: element.colorType, text: element.reason)
                cell.lbBookTitle.setTextWithLetterSpacing(text: element.title, letterSpacing: -0.07, lineHeight: 17)
                cell.lbWriter.setTextWithLetterSpacing(text: element.author, letterSpacing: -0.06, lineHeight: 14)
        }.disposed(by: rx.disposeBag)
        
        
        viewModel.times.bind(to: timeListCollectionView.rx.items(cellIdentifier: String(describing: RoundCollectionCell.self), cellType: RoundCollectionCell.self)) { (row, element, cell) in
            cell.lbRoundText.setTextWithLetterSpacing(text: element, letterSpacing: -0.06, lineHeight: 20)
            if row == 0 {
                cell.lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                cell.lbRoundText.textColor = .white
                cell.backgroundColor = ColorUtils.colorTimeSelected
            } else {
                cell.lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .regular)
                cell.lbRoundText.textColor = ColorUtils.color68
                cell.backgroundColor = ColorUtils.color243
            }
            
        }.disposed(by: rx.disposeBag)
        
        timeListCollectionView.rx
            .itemSelected
            .do(onNext: { [unowned self] indexPath in
                self.timeListCollectionView.indexPathsForVisibleItems.forEach { indexPath in
                    // 레이어 보더 모두 해제
                    let cell = self.timeListCollectionView.cellForItem(at: indexPath) as? RoundCollectionCell
                    cell?.lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .regular)
                    cell?.lbRoundText.textColor = ColorUtils.color68
                    cell?.backgroundColor = ColorUtils.color243
                }
            }).subscribe(onNext: { [unowned self] indexPath in
                let cell = self.timeListCollectionView.cellForItem(at: indexPath) as? RoundCollectionCell
                cell?.lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                cell?.lbRoundText.textColor = .white
                cell?.backgroundColor = ColorUtils.colorTimeSelected
            }).disposed(by: rx.disposeBag)
        
        viewModel.selectedData.bind(to: selectedBookListCollectionView.rx.items(cellIdentifier: String(describing: selectedBookCollectionCell.self), cellType: selectedBookCollectionCell.self)) { (row, element, cell) in
            
            //            let sameElement = self.viewModel.copyWriteData.first { $0.id == element }
            //
            //            cell.bookCover.bind(color: sameElement!.color, text: sameElement!.content)
            //            cell.lbBookTitle.setTextWithLetterSpacing(text: sameElement!.book, letterSpacing: -0.08, lineHeight: 16)
            //            cell.lbWriter.setTextWithLetterSpacing(text: sameElement!.write, letterSpacing: -0.07, lineHeight: 17)
            //            cell.lbBookSummary.setTextWithLetterSpacing(text: "1줄\n2줄\n불라불라라라라라라라라라라라라라라라라라라", letterSpacing: 0, lineHeight: 18)
            //            cell.layoutIfNeeded()
            //            cell.lbBookSummary.lineBreakMode = .byTruncatingTail
        }.disposed(by: rx.disposeBag)
    }
}

extension MainViewController {
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(naverMapView)
        self.view.addSubview(profileBaseView)
        self.view.addSubview(baseView)
        self.baseView.addSubview(timeListCollectionView)
        self.baseView.addSubview(separateLine)
        self.baseView.addSubview(bookListCollectionView)
        self.baseView.addSubview(btnCurrentLocation)
        self.view.addSubview(selectedBaseView)
        self.selectedBaseView.addSubview(selectedBookListCollectionView)
        self.selectedBaseView.addSubview(lbSelecteTime)
        self.selectedBaseView.addSubview(ivLocation)
        self.selectedBaseView.addSubview(lbSelecteLocation)
        self.selectedBaseView.addSubview(selectedSeparateLine)
        self.view.addSubview(btnWrite)
        
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
        setNaverMap()
    }
    
    private func setLayout() {
        naverMapView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width).multipliedBy(1)
            make.height.equalTo(self.view.snp.height).multipliedBy(1)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
        }
        
        profileBaseView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(153)
            make.height.equalTo(46)
        }
        
        baseView.snp.makeConstraints { (make) in
            make.height.equalTo(view.snp.width).offset(-2)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        btnCurrentLocation.snp.makeConstraints { (make) in
            make.bottom.equalTo(baseView.snp.top).offset(-24)
            make.trailing.equalTo(baseView.snp.trailing).offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        timeListCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(baseView.snp.top)
            make.leading.equalTo(baseView.snp.leading)
            make.trailing.equalTo(baseView.snp.trailing)
            make.height.equalTo(62)
        }
        
        separateLine.snp.makeConstraints { (make) in
            make.top.equalTo(baseView.snp.top).offset(62)
            make.leading.equalTo(baseView.snp.leading)
            make.trailing.equalTo(baseView.snp.trailing)
            make.height.equalTo(1)
            make.bottom.equalTo(bookListCollectionView.snp.top)
        }
        
        bookListCollectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(baseView.snp.leading)
            make.trailing.equalTo(baseView.snp.trailing)
            make.bottom.equalTo(baseView.snp.bottom)
        }
        
        btnWrite.snp.makeConstraints { (make) in
            make.width.equalTo(58)
            make.height.equalTo(58)
            make.bottom.equalToSuperview().offset(-24)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        selectedSeparateLine.snp.makeConstraints { (make) in
            make.top.equalTo(lbSelecteLocation.snp.bottom).offset(14)
            make.leading.equalTo(baseView.snp.leading).offset(20)
            make.trailing.equalTo(baseView.snp.trailing).offset(-20)
            make.height.equalTo(1)
            make.bottom.equalTo(selectedBookListCollectionView.snp.top).offset(-15)
        }
        
        selectedBaseView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view.snp.width).offset(-73)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-36)
        }
        
        selectedBookListCollectionView.snp.makeConstraints { (make) in
            //            make.top.equalTo(selectedBaseView.snp.top).offset(90)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            //            make.height.equalTo(168)
            make.bottom.equalToSuperview().offset(-44)
        }
        
        lbSelecteTime.snp.makeConstraints { (make) in
            make.top.equalTo(selectedBaseView.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(19)
        }
        
        ivLocation.snp.makeConstraints { (make) in
            make.top.equalTo(lbSelecteTime.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        lbSelecteLocation.snp.makeConstraints { (make) in
            make.top.equalTo(ivLocation.snp.top)
            make.leading.equalTo(ivLocation.snp.trailing).offset(3)
            make.height.equalTo(17)
            make.trailing.equalTo(lbSelecteTime)
        }
    }
    
    private func setNaverMap() {
        naverMapView.showCompass = false
        naverMapView.showZoomControls = false
        naverMapView.showLocationButton = false
        naverMapView.showScaleBar = false
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            print("LocationManager didChangeAuthorization denied")
        case .notDetermined:
            print("LocationManager didChangeAuthorization notDetermined")
        case .authorizedWhenInUse:
            print("LocationManager didChangeAuthorization authorizedWhenInUse")
            
            locationManager?.requestLocation()
        case .authorizedAlways:
            print("LocationManager didChangeAuthorization authorizedAlways")
            
            locationManager?.requestLocation()
        case .restricted:
            print("LocationManager didChangeAuthorization restricted")
        default:
            print("LocationManager didChangeAuthorization")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { (location) in
            mapView.locationOverlay.location = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            print("location:  ",location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("----------- didFailWithError \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
            locationManager?.stopMonitoringSignificantLocationChanges()
            return
        }
    }
}

extension MainViewController: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        sortingMarker(picks: naverMapView.mapView.pickAll(point, withTolerance: 3))
    }
    
    private func sortingMarker(picks: [NMFPickable]? ) {
        let sortMarkers = picks?.filter { $0.isKind(of: NMFMarker.self) }
        let count = sortMarkers?.count ?? 0
        var selectedMarkers: [UInt] = []
        
        for idx in 0..<count {
            if let marker = sortMarkers?[idx] as? NMFMarker {
                selectedMarkers.append(marker.tag)
            }
        }
        
        viewModel.selectedData.onNext(selectedMarkers)
    }
    
}
