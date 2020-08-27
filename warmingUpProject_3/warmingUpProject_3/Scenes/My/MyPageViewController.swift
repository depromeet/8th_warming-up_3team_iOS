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
import NSObject_Rx
import KakaoSDKUser

class MyPageViewController: UIViewController, ViewModelBindableType {
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
        
        viewModel.bookList.bind(to: bookListCollectionView.rx.items(cellIdentifier: String(describing: MyPageBookCollectionCell.self), cellType: MyPageBookCollectionCell.self)) { (row, element, cell) in
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
        naviView.backgroundColor = .red
        
        
        return naviView
    }()
    
    let btnBack: UIButton = {
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "btnLeftarrow24"), for: .normal)
        return btnBack
    }()
    
    let bookListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 42
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSize(width: (Dimens.deviceWidth * 0.34667), height: (Dimens.deviceWidth * 0.34667) + 38 + 60 + 14)
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: Dimens.deviceWidth, height: 300)
        let bookListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bookListCollectionView.contentInset = UIEdgeInsets(top: 0, left: 34, bottom: 0, right: 39)
        bookListCollectionView.backgroundColor = .white
        bookListCollectionView.showsHorizontalScrollIndicator = false
        bookListCollectionView.register(HeaderCollectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCollectionCell.self))
        bookListCollectionView.register(MyPageBookCollectionCell.self, forCellWithReuseIdentifier: String(describing: MyPageBookCollectionCell.self))
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
