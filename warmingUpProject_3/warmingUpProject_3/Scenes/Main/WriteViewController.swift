//
//  WriteViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/18.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx
import NMapsMap

class WriteViewController: UIViewController, ViewModelBindableType {
    
  var viewModel: WriteViewModel!
  
  let exitImg: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "btnClose24")
    return img
  }()
  

  let titleLabel: UILabel = {
    let label = UILabel()
    label.frame.size = CGSize(width: 207, height: 18)
    label.text = "기록 남기기"
    label.textAlignment = .center
    label.font = label.font.withSize(15)
    return label
  }()
  
  let saveBtn: UIButton = {
    let btn = UIButton()
    btn.setTitle("저장", for: .normal)
    btn.setTitleColor(.black, for: .normal)
    return btn
  }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    let writeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        setUI()
        exitImg.addGestureRecognizer(tapGesture)
        exitImg.isUserInteractionEnabled = true
      
    }
    
    func bindViewModel() {
        
    }
    
}

extension WriteViewController {
  
  @objc func touchToPickPhoto() {
    self.dismiss(animated: true, completion: nil)
  }

    private func setUI() {
      self.view.backgroundColor = .white
      self.view.addSubview(exitImg)
      self.view.addSubview(titleLabel)
      self.view.addSubview(saveBtn)
      self.view.addSubview(mainView)
      self.view.addSubview(writeView)
      
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
          $0.trailing.equalTo(saveBtn.snp.leading).offset(0)
        }
        
        saveBtn.snp.makeConstraints {
          $0.centerY.equalTo(titleLabel.snp.centerY)
          $0.trailing.equalToSuperview().offset(-24)
          $0.height.equalTo(30)
          $0.width.equalTo(50)
        }
        
        mainView.snp.makeConstraints {
            $0.height.equalTo(269)
            $0.width.equalToSuperview()
            $0.top.equalTo(exitImg.snp.bottom).offset(16)
        }
        
        writeView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(mainView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
}
