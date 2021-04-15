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
                if let adder = element as? Address {
                    cell.lbText.text = adder.roadAddress
                    cell.lbSubText.text = adder.jibunAddress
                } else if let place = element as? Document {
                    cell.lbText.text = place.placeName
                    cell.lbSubText.text = place.addressName
                }
        }
        .disposed(by: rx.disposeBag)
        
        // 주소 검색일 경우
        Observable
            .zip(adderCollectionView.rx.itemSelected, adderCollectionView.rx.modelSelected(Any.self))
            .bind { [unowned self] indexPath, element in
                if let adder = element as? Address {
                    let lat = Double(adder.y) ?? 0
                    let log = Double(adder.x) ?? 0
                    self.viewModel.model?.lat = lat
                    self.viewModel.model?.log = log
                    self.viewModel.model?.roadAddress = adder.roadAddress
                    self.viewModel.model?.jibunAddress = adder.jibunAddress
                    self.viewModel.adderTitle.onNext(adder.jibunAddress)
                } else if let place = element as? Document {
                    let lat = Double(place.y) ?? 0
                    let log = Double(place.x) ?? 0
                    self.viewModel.model?.lat = lat
                    self.viewModel.model?.log = log
                    self.viewModel.model?.roadAddress = place.placeName
                    self.viewModel.model?.jibunAddress = place.addressName
                    self.viewModel.adderTitle.onNext(place.placeName)
                }
                self.navigationController?.popViewController(animated: true)
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
        textView.textContainerInset = UIEdgeInsets(top: 11, left: 48, bottom: 10, right: 40)
        
        textView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textView.attributedText = TextUtils.attributedPlaceholder(text: "주소나 장소명을 찾아보세요.", letterSpacing: -0.07, aligment: .left)
        return textView
    }()
    
    let btnSearch: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "icnSearch24"), for: .normal)
        return b
    }()
    
    let btnDelete: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "btnDelete24"), for: .normal)
        return b
    }()
    
    let btnLocation: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "icnLocation24"), for: .normal)
        return b
    }()
    
    let adderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 10, height: 34)
        layout.scrollDirection = .vertical
        let adderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
            viewModel.geoCodeProvider.rx
                .request(.geocode(addr: textView.text))
                .subscribe(onSuccess: { (res) in
                
                // 지번으로 검색하면
                if let geocodeModel = try? JSONDecoder().decode(GeocodeModel.self, from: res.data) {
                    self.viewModel.adderData.onNext(geocodeModel.addresses)
                }
                    // 검색해서 결과가 없는 경우
                else {
                    self.viewModel.searchProvider
                        .rx.request(.place(addr: textView.text))
                        .subscribe(onSuccess: { (response) in
                            
                        if let placeModel = try? JSONDecoder().decode(PlaceModel.self, from: response.data) {
                            self.viewModel.adderData.onNext(placeModel.documents)
                        }
                            
                        }) { (err) in
                            print(err)
                    }
                    .disposed(by: self.rx.disposeBag)
                }
                print(res)
            }) { (err) in
                print(err)
            }
            .disposed(by: rx.disposeBag)
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setPlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            setPlaceholder()
        }
    }
    
    private func setPlaceholder() {
        if textView.text == "주소나 장소명을 찾아보세요." {
            
            textView.text = ""
            textView.typingAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium),
                NSAttributedString.Key.foregroundColor : ColorUtils.color34
            ]
            
        } else if textView.text == "" || textView.text.isEmpty {
            
            textView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            textView.attributedText = TextUtils.attributedPlaceholder(text: "주소나 장소명을 찾아보세요.", letterSpacing: -0.07)
        }
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
        self.textView.addSubview(btnSearch)
        self.textView.addSubview(btnDelete)
        self.view.addSubview(btnLocation)
        self.view.addSubview(adderCollectionView)
        
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
        
        btnLocation.snp.makeConstraints {
            $0.top.equalTo(textView.snp.top).offset(8)
            $0.leading.equalTo(textView.snp.trailing).offset(12)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        btnSearch.snp.makeConstraints {
            $0.top.equalTo(textView.snp.top).offset(8)
            $0.leading.equalTo(textView.snp.leading).offset(12)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        //FIXME: 버튼 노출 안되네
        btnDelete.snp.makeConstraints {
            $0.top.equalTo(textView.snp.top).offset(8)
            $0.leading.equalTo(Dimens.deviceWidth * 0.94)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
            $0.bottom.equalTo(textView.snp.bottom).offset(-8)
        }
        
        adderCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
