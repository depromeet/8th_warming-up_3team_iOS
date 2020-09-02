//
//  HomeReviewDetail.swift
//  warmingUpProject_3
//
//  Created by JieunKim on 2020/09/02.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx
import NMapsMap

class HomeReviewDetailViewController:
UIViewController,ViewModelBindableType, UITextViewDelegate {
    
    var viewModel: ReviewDetailModel!
    
    let exitImg: UIImageView = { // 뒤로가기 버튼
        let img = UIImageView()
        img.image = UIImage(named: "btnLeftarrow24")
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 207, height: 18)
        label.text = "외로운 간고등어님의 기록"
        label.textAlignment = .center
        label.font = label.font.withSize(15)
        return label
    }()
    
    let scrollView = UIScrollView()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorUtils.colorCoverWhite
        return view
    }()
    
    let bookCoverView: BookCoverView = {
        let book = BookCoverView()
        book.backgroundColor = ColorUtils.color217
        return book
    }()
    
    let writeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let userTitleView: UIView = { // userView
        let userTitleView = UIView()
        let titleLabel = UILabel()
        let userImg = UIImageView()
        
        titleLabel.text = "외로운 간고등어님 이 남긴 기록입니다."
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        userTitleView.addSubview(titleLabel)
        userTitleView.addSubview(userImg)
        
        userTitleView.backgroundColor = .clear
        
        userTitleView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        userImg.snp.makeConstraints {
            $0.leading.equalTo(userTitleView.snp.leading).offset(20)
            $0.top.equalTo(userTitleView.snp.top).offset(28)
            $0.height.equalTo(28)
            $0.width.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(userTitleView.snp.leading).offset(56)
            $0.top.equalTo(userTitleView.snp.top).offset(28)
        }
        
        return userTitleView
    }()

    
    let detailBookView: UIView = {
        
        let bookView = UIView()
        let bookImg = UIImageView(image: UIImage(named: "btnLeftarrow24")) // 이미지
        let bookTitle = UILabel() // 집의 귓속말
        let authorTitle = UILabel() // 최준석 지음
        let detailLabel = UILabel() // 처음 내 집을 지으며
        
 
        bookTitle.text = "집의 귓속말"
        bookTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        authorTitle.text = "최준석 지음 | 아트북스"
        authorTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        detailLabel.text = "처음 내 집을 지으며 ~"
        detailLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        
        bookView.addSubview(bookImg)
        bookView.addSubview(bookTitle)
        bookView.addSubview(authorTitle)
        bookView.addSubview(detailLabel)

        bookView.snp.makeConstraints {
            $0.height.equalTo(88)
        }
            
        bookImg.snp.makeConstraints {
            $0.leading.equalTo(bookView.snp.leading).offset(15)
            $0.top.equalTo(bookView.snp.top).offset(14)
            $0.height.equalTo(60)
            $0.width.equalTo(46)
        }
        
        bookTitle.snp.makeConstraints {
            $0.leading.equalTo(bookImg.snp.leading).offset(16)
            $0.top.equalTo(bookView.snp.top).offset(14)
        }
        
        authorTitle.snp.makeConstraints {
            $0.leading.equalTo(bookImg.snp.leading).offset(15)
            $0.top.equalTo(bookTitle.snp.bottom).offset(5)
        }
        
        detailLabel.snp.makeConstraints {
            $0.leading.equalTo(bookImg.snp.leading).offset(15)
            $0.top.equalTo(authorTitle.snp.bottom).offset(9)
        }
        
        return bookView
    }()

    
    let bookInfoView: UIView = {
        let infoView = UIView()
        
        let timeLabel = UILabel() // 나른한 낮시간,
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        timeLabel.text = "나른한 낮시간,"
        
//        timeLabel.attributedText = TextUtils.attributedPlaceholder(text: "북커버에 남길 감상이나 문구를 적어주세요 (32자)", letterSpacing: -0.07)
        
        let locationImg = UIImageView(image: UIImage(named: "locationImg"))
        let locationLabel = UILabel() // 망원동, 아틀리에 크레타
        locationLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        locationLabel.text = "망원동, 아틀리에 크레타"
        
        let quotesImg = UIImageView(image: UIImage(named: "icnDoubleQuotes")) // 따옴표 이미지
        
        let opinionLabel = UILabel()
        opinionLabel.text = "나도 언젠간 예쁜 카페 같은 공간을 가지고 싶다는 생각을 줄곧 해왔습니다. 예쁘고 감각적이 인테리어 소품들이 즐비한 카페에서 이 책을 읽다보니. 더 늦기 전에 내 취향에 맞는 집을 짓고 소중한 사람들과 함께하는 행복한 삶을 살고 싶다는 생각이 들었습니다. 햇빛이 잘드는 예쁜 카페에서 저의 꿈같은 책을 읽다보니 저절로 힐링이 되네요."
        opinionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        infoView.addSubview(timeLabel)
        infoView.addSubview(locationImg)
        infoView.addSubview(locationLabel)
        infoView.addSubview(quotesImg)
        infoView.addSubview(opinionLabel)
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(5)
        }
        
        locationImg.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImg.snp.trailing).offset(3)
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
        }
        
        quotesImg.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(24)
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(locationLabel.snp.bottom).offset(33)
        }
        
        opinionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(quotesImg.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(20)
        }
        
        return infoView
    }()

    let tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 7
        layout.estimatedItemSize = CGSize(width: 10, height: 34)
        layout.scrollDirection = .vertical
        let tagListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tagListCollectionView.contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 12, right: 20)
        tagListCollectionView.backgroundColor = .white
        tagListCollectionView.showsVerticalScrollIndicator = false
        tagListCollectionView.register(RoundCollectionCell.self, forCellWithReuseIdentifier: String(describing: RoundCollectionCell.self))
        return tagListCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToExitBtn))
        exitImg.addGestureRecognizer(tapGesture)
        exitImg.isUserInteractionEnabled = true
    }
    
    @objc func tapLocationView() {
//        viewModel.actionLocationView()
    }
    
    @objc func tapBookView() {
//        viewModel.actionBookView()
    }
    
    
    func bindViewModel() {
        //MARK: 바인딩 처리 추후 예정
    }
}

extension HomeReviewDetailViewController {
    
    @objc func touchToExitBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        self.view.backgroundColor = ColorUtils.color242
        scrollView.backgroundColor = .white
        self.view.addSubview(exitImg)
        self.view.addSubview(titleLabel)
//        self.view.addSubview(saveBtn)
        self.view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        scrollView.addSubview(writeView)
        mainView.addSubview(bookCoverView)
        writeView.addSubview(userTitleView)
        
        writeView.addSubview(detailBookView)
        writeView.addSubview(bookInfoView)
        writeView.addSubview(tagCollectionView)
        
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
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(exitImg.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.height.equalTo(269)
            $0.width.equalTo(scrollView)
            $0.top.equalTo(scrollView.snp.top)
        }
        
        writeView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.height.equalTo(678 + 34 + 28)
            $0.top.equalTo(mainView.snp.bottom)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }
        
        bookCoverView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(71)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(168)
        }
        
        
        userTitleView.snp.makeConstraints {
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(55)
        }
        
        
        detailBookView.snp.makeConstraints {
            $0.top.equalTo(userTitleView.snp.bottom)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(55)
        }
        
        bookInfoView.snp.makeConstraints {
            $0.top.equalTo(detailBookView.snp.bottom).offset(14)
            $0.leading.equalTo(writeView.snp.leading).offset(20)
            $0.trailing.equalTo(writeView.snp.trailing).offset(-20)
            $0.height.equalTo(40)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookInfoView.snp.bottom)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(Dimens.deviceWidth).offset(-30)
            $0.bottom.equalToSuperview()
        }
    }

}



