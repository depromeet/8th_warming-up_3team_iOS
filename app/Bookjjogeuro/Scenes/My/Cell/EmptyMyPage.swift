//
//  EmptyMyPage.swift
//  warmingUpProject_3
//
//  Created by JieunKim on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import Foundation
import SnapKit

class EmptyMyPage: UIView {
    let emptyImg = UIImageView(image: UIImage(named: "imgMypageEmpty"))
    
    let lbEmptyText: UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        l.textAlignment = .center
        l.setTextWithLetterSpacing(text: "책장에 기록이 없네요 ㅜ.ㅠ\n글쓰기 버튼을 눌러 기록해 보세요", letterSpacing: -0.08, lineHeight: 20, font: .systemFont(ofSize: 14, weight: .medium), color: ColorUtils.color170)
        return l
    }()
    
    let gradientView = UILabel()
    
    let gradientLayer: CAGradientLayer = {
        let gra = CAGradientLayer()
        gra.colors = [
            UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor,
            UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1).cgColor
        ]
        gra.type = .axial
        gra.startPoint = CGPoint(x: .zero, y: 0.5)
        gra.endPoint = CGPoint(x: 1, y: 0.5)
        return gra
    }()
    
    var btnWrite: UIButton = {
        let btnWrite = UIButton(type: .custom)
        btnWrite.backgroundColor = .white
        btnWrite.setImage(#imageLiteral(resourceName: "icnWrite"), for: .normal)
        
//        btnWrite.layer.masksToBounds = false
        btnWrite.layer.cornerRadius = 29
        
        btnWrite.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        btnWrite.layer.shadowOpacity = 1
        btnWrite.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnWrite.layer.shadowRadius = 4 / 2
        btnWrite.layer.shadowPath = nil
        
        
        let radius: CGFloat = btnWrite.frame.width / 2.0
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * radius, height: btnWrite.frame.height)).cgPath
        
        let layer1 = CALayer()
//        btnWrite.layer.masksToBounds = false
        layer1.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.025).cgColor
        layer1.shadowOpacity = 1
        layer1.cornerRadius = 29
        layer1.shadowOffset = CGSize(width: 0, height: 4)
        layer1.shadowRadius = 10 / 2
        layer1.shadowPath = shadowPath
        layer1.shouldRasterize = true // 초기화중에는 복사 안됨
        
        btnWrite.layer.addSublayer(layer1)
        
        return btnWrite
    }()
    
    // TODO: 왜 이걸 넣어야 작동합니꽈?
    // https://stackoverflow.com/questions/25255770/multiple-drop-shadows-on-single-view-ios
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.sublayers?.forEach { (sublayer) in
//            sublayer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        gradientView.backgroundColor = UIColor(r: 242, g: 242, b: 242)
        gradientView.layer.addSublayer(gradientLayer)
        gradientView.layer.masksToBounds = true
        
        self.addSubview(emptyImg)
        self.addSubview(lbEmptyText)
        self.addSubview(gradientView)
        self.addSubview(btnWrite)
        
        gradientView.layer.addSublayer(gradientLayer)
        // TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        emptyImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(341)
            make.leading.equalToSuperview().offset(73)
            make.height.equalTo(148)
        }
        
        gradientView.snp.makeConstraints { (make) in
            make.top.equalTo(emptyImg.snp.bottom).offset(-13)
            make.leading.equalToSuperview().offset(-30)
            make.trailing.equalToSuperview()
            make.height.equalTo(25)
        }
        
        lbEmptyText.snp.makeConstraints { (make) in
            make.top.equalTo(gradientView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-48)
            make.height.equalTo(40)
        }
        
        btnWrite.snp.makeConstraints { (make) in
            make.width.equalTo(58)
            make.height.equalTo(58)
            make.bottom.equalToSuperview().offset(-124)
            make.trailing.equalTo(lbEmptyText.snp.trailing).offset(-12)
        }
    }
}
