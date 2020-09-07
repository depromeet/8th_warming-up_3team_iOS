//
//  MainViewController+View.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/07.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import NMapsMap

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
                cameraUpdate.pivot = CGPoint(x: 0.5, y: 0.3)
                self.mapView.moveCamera(cameraUpdate)
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
        
        
        // 네이버 지도에서 선택된 마커가 들어오는 경우 처리
        viewModel.selectedData
            .subscribe(onNext: { [unowned self] values in
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
        //
        //            .bind(to: bookListCollectionView.rx.items(cellIdentifier: String(describing: EmptyCollectionCell.self), cellType: EmptyCollectionCell.self)) { (row, element, cell) in
        //                print(1)
        //            }.disposed(by: rx.disposeBag)
        
        
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
    
    func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(naverMapView)
        self.view.addSubview(profileBaseView)
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
        
        naverMapView.bringSubviewToFront(btnCurrentLocation)
        
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
        setNaverMap()
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
