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
            $0.leading.equalTo(bookView.snp.bottom)
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
        infoView.addSubview(quotesImg)
        infoView.addSubview(opinionLabel)
        
        return infoView
    }()
    
    let bookCommentView: UIView = {
        let commentView = UIView()
        let textView = UITextView()
        commentView.backgroundColor = ColorUtils.color247
        
        let seperLine = UILabel()
        seperLine.backgroundColor = ColorUtils.color242
        commentView.addSubview(seperLine)
        
        seperLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-14)
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        return commentView
    }()
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.tag = 222
        textView.textContainer.maximumNumberOfLines = 0
        textView.textAlignment = .left
        textView.backgroundColor = ColorUtils.color247
        textView.attributedText = TextUtils.attributedPlaceholder(text: "이 책을 이 위치에 남기는 이유를 알려주세요.", letterSpacing: 0, aligment: .left)
        return textView
    }()
    
    let suggestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 10, height: 34)
        layout.scrollDirection = .horizontal
        let suggestListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        suggestListCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        suggestListCollectionView.backgroundColor = .white
        suggestListCollectionView.showsHorizontalScrollIndicator = false
        suggestListCollectionView.register(RoundCollectionCell.self, forCellWithReuseIdentifier: String(describing: RoundCollectionCell.self))
        
        return suggestListCollectionView
    }()
    
    let lbTime: UILabel = {
        let lbTime = UILabel()
        lbTime.setTextWithLetterSpacing(text: "이 시간에 추천해요", letterSpacing: 0, lineHeight: 17, font: UIFont.systemFont(ofSize: 14, weight: .medium), color: ColorUtils.color34)
        
        return lbTime
    }()
    
    let lbTag: UILabel = {
        let lbTag = UILabel()
        lbTag.setTextWithLetterSpacing(text: "태그", letterSpacing: 0, lineHeight: 17, font: UIFont.systemFont(ofSize: 14, weight: .medium), color: ColorUtils.color34)
        let seperLine = UILabel()
        seperLine.backgroundColor = ColorUtils.color242
        lbTag.addSubview(seperLine)
        
        seperLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-15)
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        return lbTag
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
        writeView.addSubview(bookCommentView)
        writeView.addSubview(commentTextView)
        writeView.addSubview(lbTime)
        writeView.addSubview(suggestCollectionView)
        writeView.addSubview(lbTag)
        writeView.addSubview(tagCollectionView)
        
//        scrollView.keyboardDismissMode = .onDrag
        bookInfoView.delegate = self
        commentTextView.delegate = self
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
//            $0.top.equalTo(colorListCollectionView.snp.bottom)
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
        
        bookCommentView.snp.makeConstraints {
            $0.top.equalTo(bookInfoView.snp.bottom).offset(14)
            $0.leading.equalTo(writeView.snp.leading).offset(20)
            $0.trailing.equalTo(writeView.snp.trailing).offset(-20)
            $0.height.equalTo(146)
        }
        
        commentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(bookCommentView.snp.top).offset(16)
            make.bottom.equalTo(bookCommentView.snp.bottom).offset(-16)
            make.leading.equalTo(bookCommentView.snp.leading).offset(12)
            make.trailing.equalTo(bookCommentView.snp.trailing).offset(-12)
        }
        
        lbTime.snp.makeConstraints { (make) in
            make.top.equalTo(bookCommentView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(17)
        }
        
        suggestCollectionView.snp.makeConstraints {
            $0.top.equalTo(lbTime.snp.bottom)//.offset(14)
            $0.leading.equalTo(writeView.snp.leading).offset(20)
            $0.trailing.equalTo(writeView.snp.trailing).offset(-20)
            $0.height.equalTo(63)
        }
        
        lbTag.snp.makeConstraints { (make) in
            make.top.equalTo(suggestCollectionView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(17)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(lbTag.snp.bottom)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(Dimens.deviceWidth).offset(-30)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setPlaceholder() {
        if bookInfoView.text == "북커버에 남길 감상이나 문구를 적어주세요 (32자)" {
            
            bookInfoView.text = ""
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            bookInfoView.typingAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium),
                NSAttributedString.Key.foregroundColor : ColorUtils.color34,
                NSAttributedString.Key.paragraphStyle: style
            ]
            
        } else if bookInfoView.text == "" || bookInfoView.text.isEmpty {
            
            bookInfoView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            bookInfoView.attributedText = TextUtils.attributedPlaceholder(text: "북커버에 남길 감상이나 문구를 적어주세요 (32자)", letterSpacing: -0.07)
        }
    }
    
    func setPlaceholder2() {
        if commentTextView.text == "이 책을 이 위치에 남기는 이유를 알려주세요." {
            
            commentTextView.text = ""
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            commentTextView.typingAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .light),
                NSAttributedString.Key.foregroundColor : ColorUtils.color68,
                NSAttributedString.Key.paragraphStyle: style
            ]
            
        } else if commentTextView.text == "" || commentTextView.text.isEmpty {
            
            commentTextView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            commentTextView.attributedText = TextUtils.attributedPlaceholder(text: "이 책을 이 위치에 남기는 이유를 알려주세요.", letterSpacing: 0)
        }
    }
}



