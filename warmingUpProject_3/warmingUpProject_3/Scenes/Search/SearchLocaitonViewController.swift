//
//  SearchLocaitonViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/27.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx
import NMapsMap

class SearchLocaitonViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: WriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToExitBtn))
        exitImg.addGestureRecognizer(tapGesture)
        exitImg.isUserInteractionEnabled = true
    }
    
    func bindViewModel() {
        viewModel.adderData
            .bind(to: adderCollectionView.rx.items(cellIdentifier: String(describing: AdderCollectionCell.self), cellType: AdderCollectionCell.self)) { (row, element, cell) in
                
                cell.lbText.text = element.roadAddress
                cell.lbSubText.text = element.jibunAddress
                
                
        }
        .disposed(by: rx.disposeBag)
    }
    
    let exitImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "btnClose24")
        return img
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 207, height: 18)
        label.text = "위치 찾아보기"
        label.textAlignment = .center
        label.font = label.font.withSize(15)
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = ColorUtils.color247
        return textView
    }()
    
    let adderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 10, height: 34)
        layout.scrollDirection = .vertical
        let adderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //        adderCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        adderCollectionView.backgroundColor = .white
        adderCollectionView.showsVerticalScrollIndicator = false
        adderCollectionView.register(AdderCollectionCell.self, forCellWithReuseIdentifier: String(describing: AdderCollectionCell.self))
        
        return adderCollectionView
    }()
}

extension SearchLocaitonViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            viewModel.geoCodeProvider.rx.request(.geocode(addr: textView.text)).subscribe(onSuccess: { (res) in
                
                
                // This file was generated from JSON Schema using quicktype, do not modify it directly.
                // To parse the JSON, add this file to your project and do:
                //
                if let geocodeModel = try? JSONDecoder().decode(GeocodeModel.self, from: res.data) {
                    self.viewModel.adderData.onNext(geocodeModel.addresses)
                    print(geocodeModel)
                }
                
                
                print(res)
            }) { (err) in
                print(err)
            }
            .disposed(by: rx.disposeBag)
        }
        return true
    }
}

extension SearchLocaitonViewController {
    
    @objc func touchToExitBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        self.view.addSubview(exitImg)
        self.view.addSubview(titleLabel)
        self.view.addSubview(textView)
        self.view.addSubview(adderCollectionView)
        
        //
        textView.delegate = self
        
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
        
    }
    
    private func setLayout() {
        exitImg.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.leading.equalTo(exitImg.snp.trailing).offset(0)
            $0.centerX.equalToSuperview()
        }
        
        textView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-52)
            $0.height.equalTo(40)
        }
        
        adderCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
