//
//  OnBoardTypeViewController+Bind.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/10.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx
import FirebaseAuth

extension OnBoardTypeViewController: ViewModelBindableType {
    
    func bindViewModel() {
        let profile = Observable.of(["장르 박애주의", "속독가", "올빼미족", "상상 대마왕", "나노 분석가", "꿈나라"])
        profile.bind(to: profileCollectionView.rx.items(cellIdentifier: String(describing: ProfileCollectionCell.self), cellType: ProfileCollectionCell.self)) { (row, element, cell) in
            switch row {
            case 0:
                cell.ivProfile.image = UIImage(named: "img70Profile1")?.withAlignmentRectInsets(UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7))
                
            case 1:
                cell.ivProfile.image = UIImage(named: "img70Profile2")?.withAlignmentRectInsets(UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7))
                
            case 2:
                cell.ivProfile.image = UIImage(named: "img70Profile3")?.withAlignmentRectInsets(UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7))
                
            case 3:
                cell.ivProfile.image = UIImage(named: "img70Profile4")?.withAlignmentRectInsets(UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7))
                
            case 4:
                cell.ivProfile.image = UIImage(named: "img70Profile5")?.withAlignmentRectInsets(UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7))
                
            case 5:
                cell.ivProfile.image = UIImage(named: "img70Profile6")?.withAlignmentRectInsets(UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7))
                
            default:
                break
            }
            cell.lbTypeName.setTextWithLetterSpacing(text: element, letterSpacing: -0.07, lineHeight: 17)
            cell.lbTypeName.textAlignment = .center
            
        }.disposed(by: rx.disposeBag)
        
        profileCollectionView.rx
            .itemSelected
            .do(onNext: { [unowned self] indexPath in
                self.profileCollectionView.indexPathsForVisibleItems.forEach { indexPath in
                    // 레이어 보더 모두 해제
                    let cell = self.profileCollectionView.cellForItem(at: indexPath) as? ProfileCollectionCell
                    cell?.lbProfileHighLight.layer.borderWidth = 0
                    cell?.lbProfileHighLight.layer.borderColor = nil
                    
                }
            }).subscribe(onNext: { [unowned self] indexPath in
                let cell = self.profileCollectionView.cellForItem(at: indexPath) as? ProfileCollectionCell
                self.viewModel.profileType = indexPath.row
                print(indexPath.row)
                cell?.lbProfileHighLight.layer.borderWidth = 2
                cell?.lbProfileHighLight.layer.borderColor = ColorUtils.colorProfileBoard.cgColor
                self.btnNext.isEnabled = true
                self.btnNext.backgroundColor = ColorUtils.colorProfileBoard
            }).disposed(by: rx.disposeBag)
        
        
        btnNext.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [unowned self] _ in
                
                /// uid를 고유 값으로 users에서 닉네임 저장
                let uid = Auth.auth().currentUser?.uid ?? ""
                self.viewModel.ref.child("users")
                    .child(uid)
                .setValue([
                    "nickName": self.viewModel.nickName,
                    "type": self.viewModel.profileType
                ])

                self.viewModel.nextAction()
            })
            .disposed(by: rx.disposeBag)
    }
}
