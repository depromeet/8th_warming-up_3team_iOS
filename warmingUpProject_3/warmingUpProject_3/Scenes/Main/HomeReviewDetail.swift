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

class HomeReviewDetail: UIViewController,ViewModelBindableType, UITextViewDelegate {
    
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
        view.backgroundColor = ColorUtils.color242
        return view
    }()
    
    let bookCoverView: BookCoverView = {
        let book = BookCoverView(colorChip: "NAVY", text: "")
        return book
    }()
    
    let writeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let colorListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 10, height: 34)
        layout.scrollDirection = .horizontal
        let colorListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colorListCollectionView.layer.cornerRadius = 12
        colorListCollectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        colorListCollectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        colorListCollectionView.layer.shadowOpacity = 1
        colorListCollectionView.layer.shadowOffset = CGSize(width: 0, height: -2)
        colorListCollectionView.layer.shadowRadius = 6 / 2
        
        colorListCollectionView.contentInset = UIEdgeInsets(top: 22, left: 20, bottom: 2, right: 20)
        colorListCollectionView.backgroundColor = .white
        colorListCollectionView.showsHorizontalScrollIndicator = false
        colorListCollectionView.register(RoundCollectionCell.self, forCellWithReuseIdentifier: String(describing: RoundCollectionCell.self))
        
        
        return colorListCollectionView
    }()
    
    let bookTitleView: UIView = {
        let bookTitle = UIView()
        let titleLabel = UILabel()
        let seperLine = UILabel()
        titleLabel.text = "책 제목"
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        seperLine.backgroundColor = ColorUtils.color242
        
        bookTitle.addSubview(titleLabel)
        bookTitle.addSubview(seperLine)
        bookTitle.backgroundColor = .white
        
        bookTitle.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        seperLine.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(bookTitle.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bookTitle.snp.leading).offset(20)
            $0.top.equalTo(bookTitle.snp.top).offset(20)
            $0.height.equalTo(17)
        }
        
        return bookTitle
    }()
    
    
    let searchBtnView: UIButton = {
        let searchBtnView = UIButton(type: .custom)
        searchBtnView.setTitle("찾아보기", for: .normal)
        searchBtnView.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        searchBtnView.setImage(UIImage(named: "btnRightarrow24"), for: .normal)
        searchBtnView.semanticContentAttribute = .forceRightToLeft
        searchBtnView.setTitleColor(ColorUtils.color170, for: .normal)
        searchBtnView.addTarget(self, action:  #selector(tapBookView), for: .touchUpInside)
        return searchBtnView
    }()
    
    let locationView: UIView = {
        let locationTitle = UIView()
        let titleLabel = UILabel()
        let seperLine = UILabel()
        titleLabel.text = "기록을 남길 위치"
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        seperLine.backgroundColor = ColorUtils.color242
        
        locationTitle.addSubview(titleLabel)
        locationTitle.addSubview(seperLine)
        locationTitle.backgroundColor = .white
        
        locationTitle.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        seperLine.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(locationTitle.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(locationTitle.snp.leading).offset(20)
            $0.top.equalTo(locationTitle.snp.top).offset(20)
            $0.height.equalTo(17)
        }
        
        return locationTitle
    }()
    
    let selectBtnView: UIButton = {
        let b = UIButton()
        b.setTitle("선택하기", for: .normal)
        b.setImage(UIImage(named: "btnRightarrow24"), for: .normal)
        b.semanticContentAttribute = .forceRightToLeft
        b.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        b.titleLabel?.textAlignment = .right
        b.setTitleColor(ColorUtils.color170, for: .normal)
        b.addTarget(self, action:  #selector(tapLocationView), for: .touchUpInside)
        return b
    }()
    
    let writeBookcoverView: UITextView = {
        let bookcoverView = UITextView()
        bookcoverView.tag = 111
        bookcoverView.textContainer.maximumNumberOfLines = 2
        bookcoverView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        bookcoverView.attributedText = TextUtils.attributedPlaceholder(text: "북커버에 남길 감상이나 문구를 적어주세요 (32자)", letterSpacing: -0.07)
        return bookcoverView
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

extension HomeReviewDetail {
    
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
        writeView.addSubview(colorListCollectionView)
        writeView.addSubview(bookTitleView)
        bookTitleView.addSubview(searchBtnView)
        writeView.addSubview(locationView)
        locationView.addSubview(selectBtnView)
        writeView.addSubview(writeBookcoverView)
        writeView.addSubview(bookCommentView)
        writeView.addSubview(commentTextView)
        writeView.addSubview(lbTime)
        writeView.addSubview(suggestCollectionView)
        writeView.addSubview(lbTag)
        writeView.addSubview(tagCollectionView)
        
//        scrollView.keyboardDismissMode = .onDrag
        writeBookcoverView.delegate = self
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
        
        colorListCollectionView.snp.makeConstraints {
            $0.top.equalTo(writeView.snp.top)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(62)
        }
        
        bookTitleView.snp.makeConstraints {
            $0.top.equalTo(colorListCollectionView.snp.bottom)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(55)
        }
        
        searchBtnView.snp.makeConstraints { (make) in
            make.top.equalTo(bookTitleView.snp.top).offset(10)
            make.trailing.equalTo(bookTitleView.snp.trailing).offset(-20)
            make.bottom.equalTo(bookTitleView.snp.bottom).offset(-11)
        }
        
        locationView.snp.makeConstraints {
            $0.top.equalTo(bookTitleView.snp.bottom)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(55)
        }

        selectBtnView.snp.makeConstraints {
            $0.trailing.equalTo(locationView.snp.trailing).offset(-20)
            $0.top.equalTo(locationView.snp.top).offset(10)
            $0.bottom.equalTo(locationView.snp.bottom).offset(-11)
            $0.height.equalTo(24)
        }
        
        writeBookcoverView.snp.makeConstraints {
            $0.top.equalTo(locationView.snp.bottom).offset(14)
            $0.leading.equalTo(writeView.snp.leading).offset(20)
            $0.trailing.equalTo(writeView.snp.trailing).offset(-20)
            $0.height.equalTo(40)
        }
        
        bookCommentView.snp.makeConstraints {
            $0.top.equalTo(writeBookcoverView.snp.bottom).offset(14)
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
        if writeBookcoverView.text == "북커버에 남길 감상이나 문구를 적어주세요 (32자)" {
            
            writeBookcoverView.text = ""
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            writeBookcoverView.typingAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium),
                NSAttributedString.Key.foregroundColor : ColorUtils.color34,
                NSAttributedString.Key.paragraphStyle: style
            ]
            
        } else if writeBookcoverView.text == "" || writeBookcoverView.text.isEmpty {
            
            writeBookcoverView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            writeBookcoverView.attributedText = TextUtils.attributedPlaceholder(text: "북커버에 남길 감상이나 문구를 적어주세요 (32자)", letterSpacing: -0.07)
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



