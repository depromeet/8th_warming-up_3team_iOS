//
//  MainViewController+View.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/07.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import NMapsMap
import RxSwift
import RxCocoa

extension MainViewController: ViewModelBindableType {
    
    func bindViewModel() {
        btnWrite.rx.action = viewModel.writeAction()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapProfile))
        profileBaseView.addGestureRecognizer(tap)
        
        //FIXME: 현재 위치 동작안함 이벤트가 왜 안걸리지?!
        btnCurrentLocation.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { _ in
                
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: self.locationManager?.location?.coordinate.latitude ?? 37.5666102, lng: self.locationManager?.location?.coordinate.longitude ?? 126.9783881))
                self.mapView.moveCamera(cameraUpdate)
            })
            .disposed(by: rx.disposeBag)
        
        
        //MARK: getDocumentNearBy 통해 가져온 데이터 기준으로 마커 찍기
        viewModel.writeData
            .subscribe(onNext: { [unowned self ] value in
                
                //FIXME: 다 지우고 - 비효윯인데, 매번 다시 그려야하다니
                self.viewModel.markers.forEach { $0.mapView = nil }
                
                for value in value {
                    do {
//                        if let model = try value.data(as: FBWriteModel.self) {
                        let marker = NMFMarker(position: NMGLatLng(lat: value.coordinate.latitude, lng: value.coordinate.longitude))
                            
                            self.viewModel.markers.append(marker)
                        marker.iconImage = NMFOverlayImage(image: ImageUtils.getColorBookIcon("NAVY"))//(model.colorType))
                            marker.mapView = self.naverMapView.mapView
//                            marker.tag = UInt(model.userID) ?? 0
//                            marker.userInfo = ["info" : model]
//                        }
                        
                    } catch let err {
                        print("err : \(err)")
                    }
                }
            })
            .disposed(by: rx.disposeBag)
        
        
        //MARK:  네이버 지도에서 선택된 마커가 들어오는 경우 처리
        viewModel.selectedData
            .subscribe(onNext: { [unowned self] values in
                print("------ value:    \(values)")
                
                // 애니메이션 줘야함
                if values.isEmpty || values.count == 0 {
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
        
        //MARK: 책 리스트
        viewModel.writeData // write data인지는 모르겠습니다 ... ?
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
                do {
//                    if let model = try element.data(as: FBWriteModel.self) {
//
//                        cell.bookCover.bind(color: model.colorType, text: model.phrase)
//                        cell.lbBookTitle.setTextWithLetterSpacing(text: model.title, letterSpacing: -0.07, lineHeight: 17)
//                        cell.lbWriter.setTextWithLetterSpacing(text: model.author, letterSpacing: -0.06, lineHeight: 14)
//                    }
                } catch let err {
                    print("err : \(err)")
                }
        }
        .disposed(by: rx.disposeBag)
        
        //MARK: 시간 최초 바인드 시, 이거 불변임
        viewModel.times
            .bind(to: timeListCollectionView.rx.items(cellIdentifier: String(describing: RoundCollectionCell.self), cellType: RoundCollectionCell.self)) {
                (row, element, cell) in
                cell.isSelected = (row == self.viewModel.selTime.row) ? true : false
                cell.lbRoundText.setTextWithLetterSpacing(text: element, letterSpacing: -0.06, lineHeight: 20)
                
                if cell.isSelected {
                    cell.lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                    cell.lbRoundText.textColor = .white
                    cell.backgroundColor = ColorUtils.colorTimeSelected
                } else {
                    cell.lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .regular)
                    cell.lbRoundText.textColor = ColorUtils.color68
                    cell.backgroundColor = ColorUtils.color243
                }
        }
        .disposed(by: rx.disposeBag)
        
        //MARK: 타임 선택 시 처리 하기
        Observable
            .zip(timeListCollectionView.rx.itemSelected, timeListCollectionView.rx.modelSelected(String.self))
            .do(onNext: { [unowned self] indexPath in
                
                // 이전 선택된 레이어 보더 해제 - 초기값 [0, 0]
                let cell = self.timeListCollectionView.cellForItem(at: self.viewModel.selTime) as? RoundCollectionCell
                cell?.lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .regular)
                cell?.lbRoundText.textColor = ColorUtils.color68
                cell?.backgroundColor = ColorUtils.color243
                
                // 선택된 인덱스 저장
                self.viewModel.selTime = indexPath.0
            })
            .bind { [unowned self] indexPath, selTime in
                
                let cell = self.timeListCollectionView.cellForItem(at: indexPath) as? RoundCollectionCell
                
                cell?.lbRoundText.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                cell?.lbRoundText.textColor = .white
                cell?.backgroundColor = ColorUtils.colorTimeSelected
                
                // 데이터 날리기 위해서
                self.viewModel.writeData.onNext([])
                
                self.viewModel.getTimeDocumentNearBy(time: selTime, latitude: self.locationManager?.location?.coordinate.latitude ?? 37.5666102, longitude: self.locationManager?.location?.coordinate.longitude ?? 126.9783881, distance: 1)
        }
        .disposed(by: rx.disposeBag)
        
        // 선택됬을 때
        viewModel.selectedData.bind(to: selectedBookListCollectionView.rx.items(cellIdentifier: String(describing: selectedBookCollectionCell.self), cellType: selectedBookCollectionCell.self)) { [unowned self] (row, element, cell) in
            guard let info = element["info"] as? FBWriteModel else { return }
            
            
            self.lbSelecteTime.setTextWithLetterSpacing(text: info.time, letterSpacing: -0.08, lineHeight: 19)
            self.lbSelecteLocation.setTextWithLetterSpacing(text: "\(info.jibunAddress ?? ""), \(info.roadAddress ?? "")", letterSpacing: -0.07, lineHeight: 17)
            
            // 본문 내용
            cell.bookCover.bind(color: info.colorType, text: info.phrase)
            cell.lbBookTitle.setTextWithLetterSpacing(text: info.title, letterSpacing: -0.08, lineHeight: 16)
            cell.lbWriter.setTextWithLetterSpacing(text: info.author, letterSpacing: -0.07, lineHeight: 17)
            cell.lbBookSummary.setTextWithLetterSpacing(text: info.description, letterSpacing: 0, lineHeight: 18)
            cell.layoutIfNeeded()
            cell.lbBookSummary.lineBreakMode = .byTruncatingTail
        }.disposed(by: rx.disposeBag)
    }
    
    func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(naverMapView)
        self.view.addSubview(profileBaseView)
        self.profileBaseView.addSubview(profileTypeImageView)
        self.profileBaseView.addSubview(lbNickName)
        self.view.addSubview(baseView)
        self.baseView.addSubview(timeListCollectionView)
        self.baseView.addSubview(separateLine)
        self.baseView.addSubview(bookListCollectionView)
        self.naverMapView.addSubview(btnCurrentLocation)
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
        setProfile()
    }
    
    func setLayout() {
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
        
        profileTypeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(profileBaseView.snp.top).offset(4)
            make.leading.equalTo(profileBaseView.snp.leading).offset(4)
            make.width.equalTo(38)
            make.bottom.equalTo(profileBaseView.snp.bottom).offset(-4)
        }
        
        lbNickName.snp.makeConstraints { (make) in
            make.top.equalTo(profileBaseView.snp.top).offset(15)
            make.leading.equalTo(profileTypeImageView.snp.trailing).offset(9)
            make.trailing.equalTo(profileBaseView.snp.trailing).offset(-16)
            make.bottom.equalTo(profileBaseView.snp.bottom).offset(-15)
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
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
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
        naverMapView.bringSubviewToFront(btnCurrentLocation)
        naverMapView.showCompass = false
        naverMapView.showZoomControls = false
        naverMapView.showLocationButton = false
        naverMapView.showScaleBar = false
    }
    
    private func setProfile() {
        
        viewModel.ref.child("users").child(viewModel.getUid()).observe(.value) { [unowned self] (dataSnapshot) in
            let dic = dataSnapshot.value as? Dictionary<String, Any>
            let type: Int = dic?["type"] as! Int
            let nickName = dic?["nickName"] as! String
            
            switch type {
            case 0:
                self.profileTypeImageView.image = UIImage(named: "img28Profile1")
                
            case 1:
                self.profileTypeImageView.image = UIImage(named: "img28Profile2")
                
            case 2:
                self.profileTypeImageView.image = UIImage(named: "img28Profile3")
                
            case 3:
                self.profileTypeImageView.image = UIImage(named: "img28Profile4")
                
            case 4:
                self.profileTypeImageView.image = UIImage(named: "img28Profile5")
                
            case 5:
                self.profileTypeImageView.image = UIImage(named: "img28Profile6")
                
            default:
                break
            }

            self.lbNickName.setTextWithLetterSpacing(text: nickName, letterSpacing: -0.06, lineHeight: 16)
        }
    }
}
