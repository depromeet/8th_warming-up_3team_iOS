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
        return naverMapView.mapView
    }()
    
    let profileBaseView: UIView = {
        let profileView = UIView()
        profileView.backgroundColor = .white
        profileView.layer.cornerRadius = 23
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Profile")
        imageView.layer.cornerRadius = 19
        
        let lbTitle = UILabel()
        lbTitle.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        lbTitle.textAlignment = .center
        lbTitle.setTextWithLetterSpacing(text: "외로운 규현", letterSpacing: -0.06, lineHeight: 16)
        
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
    
    //TODO: 테스트 코드 임
    
    let baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = .white
        baseView.layer.cornerRadius = 15
        baseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        let cover = UIView()
        cover.frame.size = CGSize(width: 130, height: 168)
        cover.backgroundColor = UIColor(r: 238, g: 230, b: 161)
        cover.layer.cornerRadius = 5
        cover.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        cover.layer.shadowOpacity = 1
        cover.layer.shadowOffset = CGSize(width: 1, height: 2)
        cover.layer.shadowRadius = 4 / 2
        cover.layer.shadowPath = nil
        
        let gra = CAGradientLayer()
        gra.frame = CGRect(x: cover.frame.minX + 4, y: cover.frame.minY, width: 16, height: cover.frame.height)
        gra.colors = [
            UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        ]
        gra.type = .axial
        gra.startPoint = CGPoint(x: 0, y: 0.5)
        gra.endPoint = CGPoint(x: 1, y: 0.5)
        
        cover.layer.addSublayer(gra)
        baseView.addSubview(cover)
        
        let testView = UIView()
        testView.backgroundColor = UIColor(r: 250, g: 249, b: 248)
        
        cover.addSubview(testView)
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: TextUtils.FontType.NanumMyeongjoRegular.rawValue, size: 13)
        label.setTextWithLetterSpacing(text: "바람이 불었다. 다만 나에게 주어진 길을 묵묵히 걸어가고자 했다.", letterSpacing: -0.06, lineHeight: 20)
        
        testView.addSubview(label)
        
        cover.snp.makeConstraints { (make) in
            make.top.equalTo(baseView.snp.top).offset(79)
            make.leading.equalTo(baseView.snp.leading).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(168)
        }
        
        testView.snp.makeConstraints { (make) in
            make.top.equalTo(cover.snp.top).offset(48)
            make.leading.equalTo(cover.snp.leading)
            make.trailing.equalTo(cover.snp.trailing)
            make.bottom.equalTo(cover.snp.bottom).offset(-10)
        }
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(testView.snp.top).offset(15)
            make.leading.equalTo(testView.snp.leading).offset(15)
            make.trailing.equalTo(testView.snp.trailing).offset(-15)
            make.bottom.equalTo(testView.snp.bottom).offset(-15)
        }
        
        
        
        return baseView
    }()
    // -------------------------
    
    var btnWrite: UIButton = {
        let btnWrite = UIButton(type: .custom)
        btnWrite.backgroundColor = .white
        btnWrite.setImage(#imageLiteral(resourceName: "write"), for: .normal)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func bindViewModel() {
        btnWrite.rx.action = viewModel.writeAction()
    }
}

extension MainViewController {
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(mapView)
        self.view.addSubview(profileBaseView)
        self.view.addSubview(baseView)
        self.view.addSubview(btnWrite)
        
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
        
        profileBaseView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(153)
            make.height.equalTo(46)
        }
        
        baseView.snp.makeConstraints { (make) in
            make.height.equalTo(view.snp.width).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        btnWrite.snp.makeConstraints { (make) in
            make.width.equalTo(58)
            make.height.equalTo(58)
            make.bottom.equalToSuperview().offset(-24)
            make.trailing.equalToSuperview().offset(-22)
        }
    }
}

extension MainViewController: NMFMapViewDelegate, CLLocationManagerDelegate {
    
}
