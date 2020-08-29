//
//  MyPageViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Action
import NMapsMap
import NSObject_Rx

class MyPageViewController: UIViewController, ViewModelBindableType, NMFMapViewTouchDelegate {
    var viewModel: MyPageViewModel!
    
    override func loadView() {
        super.loadView()
        setUI()
    }
    
    override func viewDidLoad() {
        viewModel.requestUserInfo(userID: 1)
        
    }
    //MARK: - Bind
    func bindViewModel() {
        btnBack.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.bookList
            .do(onNext: { bookList in
                if bookList.isEmpty {
                    self.bookListCollectionView.addSubview(EmptyMyPage(frame: CGRect(x: .zero, y: .zero, width: Dimens.deviceWidth, height: Dimens.deviceHeight)))
                } else {
                    for subView in self.bookListCollectionView.subviews {
                        if subView is EmptyMyPage {
                            subView.removeFromSuperview()
                        }
                    }
                }
            })

            .bind(to: bookListCollectionView.rx.items(cellIdentifier: String(describing: MyPageBookCollectionCell.self), cellType: MyPageBookCollectionCell.self)) { (row, element, cell) in
            
            cell.bookCover.bind(color: element.colorType, text: element.title)
            cell.lbBookTitle.setTextWithLetterSpacing(text: element.title, letterSpacing: -0.07, lineHeight: 17)
            cell.lbWriter.setTextWithLetterSpacing(text: element.author, letterSpacing: -0.06, lineHeight: 14)
        }.disposed(by: rx.disposeBag)
        
        bookListCollectionView.rx.willDisplaySupplementaryView.subscribe(onNext: { (view, kind, cell) in
            print(view, kind, cell)
        }).disposed(by: rx.disposeBag)
    }

    //MARK: - UI Component
    let naviView: UIView = {
        let naviView = UIView()
        let label = UILabel()
        label.text = "나의 기록"
        naviView.backgroundColor = ColorUtils.colorCoverWhite
        naviView.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        return naviView
    }()
    
    let btnBack: UIButton = {
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "btnLeftarrow24"), for: .normal)
        return btnBack
    }()
    
    let bookListCollectionView: UICollectionView = {
        
        var profileView: UIView = {
            let view = UIView()
            let profileImg = UIImageView()
            let titleLabel = UILabel()
            let subLabel = UILabel()
            
            profileImg.image = UIImage(named: "img28Profile1")
            titleLabel.text = "\(UserUtils.getNickName())님이 남긴 기록"
            subLabel.text = "총 \(0) 권의 기록을 보관 중입니다."
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            subLabel.font = UIFont.systemFont(ofSize: 14)
            subLabel.textColor = ColorUtils.colorProfileBoard
            
            view.addSubview(profileImg)
            view.addSubview(titleLabel)
            view.addSubview(subLabel)
            
            profileImg.snp.makeConstraints {
                $0.centerX.equalTo(view.snp.centerX)
                $0.bottom.equalTo(titleLabel.snp.top).offset(-16)
            }
            
            titleLabel.snp.makeConstraints {
                $0.centerX.equalTo(view.snp.centerX)
                $0.centerY.equalTo(view.snp.centerY)
                $0.height.equalTo(16)
            }
            
            subLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(8)
                $0.centerX.equalTo(view.snp.centerX)
                $0.height.equalTo(14)
            }

            return view
        }()
        
        var mapView: NMFMapView = {
            let view = NMFMapView()
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 36.9204599, lng: 127.2158979))
            view.moveCamera(cameraUpdate)
            return view
        }()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 42
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSize(width: (Dimens.deviceWidth * 0.34667), height: (Dimens.deviceWidth * 0.34667) + 38 + 60 + 14)
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: Dimens.deviceWidth, height: 324)
        let bookListCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Dimens.deviceWidth, height: 1), collectionViewLayout: layout)
        bookListCollectionView.contentInset = UIEdgeInsets(top: 0, left: 34, bottom: 0, right: 39)
        
        
        bookListCollectionView.backgroundColor = ColorUtils.colorCoverWhite
        bookListCollectionView.showsHorizontalScrollIndicator = false
        bookListCollectionView.register(HeaderCollectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCollectionCell.self))
        bookListCollectionView.register(MyPageBookCollectionCell.self, forCellWithReuseIdentifier: String(describing: MyPageBookCollectionCell.self))
        
        bookListCollectionView.addSubview(profileView)
        bookListCollectionView.addSubview(mapView)
        
        profileView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(129)
            make.leading.equalToSuperview().offset(-14)
//            make.trailing.equalToSuperview().offset(14)
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom).offset(0)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(165)
            make.leading.equalToSuperview().offset(-14)
//            make.trailing.equalToSuperview().offset(300)
        }
        
        return bookListCollectionView
    }()
    
}

//MARK: private 메소드
extension MyPageViewController {
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(naviView)
        self.view.addSubview(btnBack)
        self.view.addSubview(bookListCollectionView)
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        naviView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(56)
        }
        
        btnBack.snp.makeConstraints { (make) in
            make.top.equalTo(naviView.snp.top).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(24)
            make.bottom.equalTo(naviView.snp.bottom).offset(-16)
        }
        
        bookListCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(naviView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalToSuperview()
        }
        
    }
    
}
