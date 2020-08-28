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
    
    let emptyView: UIView = {
        
        let view = UIView()
        view.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        
        let emptyImg: UIImageView = {
            let emptyImg = UIImageView()
            emptyImg.image = UIImage(named: "imgMypageEmpty")
            return emptyImg
        }()
        
        let lbEmpty: UIView = {
            
            let uiview = UIView()
            let lbEmpty1 = UILabel()
            let lbEmpty2 = UILabel()
            
            lbEmpty1.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            lbEmpty2.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            lbEmpty1.setTextWithLetterSpacing(text: "책장에 기록이 없네요 ㅜ.ㅠ", letterSpacing: -0.08, lineHeight: 16, font: .systemFont(ofSize: 16, weight: .medium), color: ColorUtils.color170)
            lbEmpty2.setTextWithLetterSpacing(text: "글쓰기 버튼을 눌러 기록해보세요", letterSpacing: -0.08, lineHeight: 16, font: .systemFont(ofSize: 16, weight: .medium), color: ColorUtils.color170)
            
            uiview.addSubview(lbEmpty1)
            uiview.addSubview(lbEmpty2)
            
            lbEmpty1.snp.makeConstraints {
                $0.top.equalTo(uiview.snp.top)
                $0.leading.equalTo(uiview.snp.leading)
                $0.trailing.equalTo(uiview.snp.trailing)
            }
            
            lbEmpty2.snp.makeConstraints {
                $0.top.equalTo(lbEmpty1.snp.top)
                $0.leading.equalTo(uiview.snp.leading)
                $0.trailing.equalTo(uiview.snp.trailing)
                $0.bottom.equalTo(uiview.snp.bottom)
            }
            
            return uiview
        }()
        
        view.addSubview(emptyImg)
        view.addSubview(lbEmpty)
    
        emptyImg.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.snp.top).offset(47)
            $0.width.equalTo(189)
            $0.height.equalTo(148)
        }
        
        lbEmpty.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(emptyImg.snp.bottom).offset(31)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        return view
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(emptyView)
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.setNeedsUpdateConstraints()
        setLayout()
    }
    
    private func setLayout() {
        emptyView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(226+40)
        }
    }
}
