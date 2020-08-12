//
//  ProfileCollectionCell.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit

class ProfileCollectionCell: UICollectionViewCell {

    let ivProfile: UIImageView = {
        let ivProfile = UIImageView()
        ivProfile.contentMode = .scaleAspectFill
        ivProfile.image = #imageLiteral(resourceName: "Profile").withAlignmentRectInsets(UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7))
        return ivProfile
    }()

    let lbProfileHighLight: UILabel = {
        let lbProfileHighLight = UILabel()
        lbProfileHighLight.layer.cornerRadius = 84 / 2
        return lbProfileHighLight
    }()

    let lbTypeName: UILabel = {
        let lbTypeName = UILabel()
        lbTypeName.font = UIFont.systemFont(ofSize: 14)
        lbTypeName.textAlignment = .center
        lbTypeName.textColor = ColorUtils.color170
        return lbTypeName
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(ivProfile)
        self.addSubview(lbTypeName)
        self.addSubview(lbProfileHighLight)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        ivProfile.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(84)
        }

        lbTypeName.snp.makeConstraints { (make) in
            make.top.equalTo(ivProfile.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(17)
        }

        lbProfileHighLight.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(84)
        }
    }
}

