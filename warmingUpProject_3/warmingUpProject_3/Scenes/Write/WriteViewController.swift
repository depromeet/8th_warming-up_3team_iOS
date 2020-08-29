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

class WriteViewController: UIViewController,ViewModelBindableType {
    
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
        viewModel.actionLocationView()
    }
    
    @objc func tapBookView() {
        viewModel.actionBookView()
    }
    
    //MAKR: 바인딩 처리
    func bindViewModel() {
        
        saveBtn.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [unowned self]_ in
                print("lat", self.viewModel.model?.lat)
                print("log", self.viewModel.model?.log)
                
                
                self.viewModel.actionSave {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            .disposed(by: rx.disposeBag)
        
        //MARK: 위치 바인딩
        viewModel.adderTitle
            .subscribe(onNext: { [unowned self] (str) in
                let attribute = TextUtils.textLetterSpacingAttribute(text: str, letterSpacing: 0, color: UIColor(r: 84, g: 90, b: 124), font: UIFont.systemFont(ofSize: 12, weight: .light))
                self.selectBtnView.setAttributedTitle(attribute, for: .normal)
            })
            .disposed(by: rx.disposeBag)
        
        //MARK: 책 제목 바인딩
        viewModel.bookTitle
            .subscribe(onNext: { [unowned self] (str) in
                let attribute = TextUtils.textLetterSpacingAttribute(text: str, letterSpacing: 0, color: UIColor(r: 84, g: 90, b: 124), font: UIFont.systemFont(ofSize: 12, weight: .light))
                self.searchBtnView.setAttributedTitle(attribute, for: .normal)
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.success.bind(to: colorListCollectionView.rx.items(cellIdentifier: String(describing: RoundCollectionCell.self), cellType: RoundCollectionCell.self)) { (row, element, cell) in
            cell.lbRoundText.snp.removeConstraints()
            cell.lbRoundText.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(4)
                make.leading.equalToSuperview().offset(4)
                make.width.equalTo(30)
                make.height.equalTo(30)
                make.trailing.equalToSuperview().offset(-4)
                make.bottom.equalToSuperview().offset(-4)
            }
            if row == 0 {
                cell.layer.borderWidth = 1
                cell.layer.borderColor = ColorUtils.color187.cgColor
            } else {
                cell.layer.borderWidth = 0
                cell.layer.borderColor = nil
            }
            cell.layer.cornerRadius = 19
            cell.lbRoundText.backgroundColor = ColorUtils.getColorChip(element).bookColor
            cell.lbRoundText.layer.cornerRadius = 15
            cell.layer.masksToBounds = true
            cell.lbRoundText.layer.masksToBounds = true
            
            
        }.disposed(by: rx.disposeBag)
        
        Observable
            .zip(colorListCollectionView.rx.itemSelected, colorListCollectionView.rx.modelSelected(String.self))
            .do(onNext: { [unowned self] indexPath in
                self.colorListCollectionView.indexPathsForVisibleItems.forEach { indexPath in
                    
                    // 레이어 보더 모두 해제
                    let cell = self.colorListCollectionView.cellForItem(at: indexPath) as? RoundCollectionCell
                    cell?.layer.borderWidth = 0
                    cell?.layer.borderColor = nil
                }
            })
            .bind { [unowned self] indexPath, selColor in
                let cell = self.colorListCollectionView.cellForItem(at: indexPath) as? RoundCollectionCell
                cell?.layer.borderWidth = 1
                cell?.layer.borderColor = ColorUtils.color187.cgColor
                self.bookCoverView.bind(color: selColor, text: self.writeBookcoverView.text ?? "")
                self.viewModel.selColor = selColor
                self.viewModel.model?.colorType = selColor
        }
        .disposed(by: rx.disposeBag)
        
        Observable
            .zip(suggestCollectionView.rx.itemSelected, suggestCollectionView.rx.modelSelected(String.self))
            .do(onNext: { [unowned self] indexPath, text in
                self.suggestCollectionView.indexPathsForVisibleItems.forEach { indexPath in
                    
                    // 레이어 보더 모두 해제
                    let cell = self.suggestCollectionView.cellForItem(at: indexPath) as? RoundCollectionCell
                    cell?.lbRoundText.setTextWithLetterSpacing(text: cell?.lbRoundText.text ?? "", letterSpacing: -0.06, lineHeight: 19.5, font: UIFont.systemFont(ofSize: 13, weight: .regular), color: ColorUtils.color231)
                    cell?.layer.borderColor = ColorUtils.color231.cgColor
                    cell?.layer.borderWidth = 1
                }
            })
            .bind { [unowned self] indexPath, text in
                let cell = self.suggestCollectionView.cellForItem(at: indexPath) as? RoundCollectionCell
                cell?.layer.borderWidth = 1
                cell?.layer.borderColor = UIColor(r: 84, g: 90, b: 124).cgColor
                cell?.lbRoundText.setTextWithLetterSpacing(text: text, letterSpacing: -0.06, lineHeight: 19.5, font: UIFont.systemFont(ofSize: 13, weight: .regular), color: UIColor(r: 84, g: 90, b: 124))
                self.viewModel.model?.time = text
        }
        .disposed(by: rx.disposeBag)
        
        viewModel.suggest.bind(to: suggestCollectionView.rx.items(cellIdentifier: String(describing: RoundCollectionCell.self), cellType: RoundCollectionCell.self)) { (row, element, cell) in
            
            cell.lbRoundText.setTextWithLetterSpacing(text: element, letterSpacing: -0.06, lineHeight: 19.5, font: UIFont.systemFont(ofSize: 13, weight: .regular), color: ColorUtils.color170)
            
            if row == 0 {
                cell.layer.borderColor = UIColor(r: 84, g: 90, b: 124).cgColor
                cell.layer.borderWidth = 1
                cell.lbRoundText.setTextWithLetterSpacing(text: element, letterSpacing: -0.06, lineHeight: 19.5, font: UIFont.systemFont(ofSize: 13, weight: .regular), color: UIColor(r: 84, g: 90, b: 124))
                
            } else {
                cell.layer.borderColor = ColorUtils.color231.cgColor
                cell.layer.borderWidth = 1
            }
            
        }.disposed(by: rx.disposeBag)
        
        Observable
            .zip(tagCollectionView.rx.itemSelected, tagCollectionView.rx.modelSelected(String.self))
            .do(onNext: { [unowned self] indexPath, text in
                //TODO: deSeleted 처리해야함
            })
            .bind { [unowned self] indexPath, text in
                let cell = self.tagCollectionView.cellForItem(at: indexPath) as? RoundCollectionCell
                print(cell?.isSelected)
                cell?.layer.borderWidth = 1
                cell?.layer.borderColor = UIColor(r: 84, g: 90, b: 124).cgColor
                cell?.lbRoundText.setTextWithLetterSpacing(text: text, letterSpacing: -0.06, lineHeight: 19.5, font: UIFont.systemFont(ofSize: 13, weight: .regular), color: UIColor(r: 84, g: 90, b: 124))
                
                let addText = text.trimmingCharacters(in: ["#"])
                self.viewModel.model?.tags.append(addText)
                print(self.viewModel.model?.tags)
        }
        .disposed(by: rx.disposeBag)
        
        viewModel.tag.bind(to: tagCollectionView.rx.items(cellIdentifier: String(describing: RoundCollectionCell.self), cellType: RoundCollectionCell.self)) { (row, element, cell) in
            cell.lbRoundText.setTextWithLetterSpacing(text: element, letterSpacing: -0.06, lineHeight: 20)
            cell.layer.borderColor = ColorUtils.color231.cgColor
            cell.layer.borderWidth = 1
            
        }.disposed(by: rx.disposeBag)
        
        
        
        
    }
}

extension WriteViewController {
    
    @objc func touchToExitBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        self.view.backgroundColor = ColorUtils.color242
        scrollView.backgroundColor = .white
        self.view.addSubview(exitImg)
        self.view.addSubview(titleLabel)
        self.view.addSubview(saveBtn)
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
        
        scrollView.keyboardDismissMode = .onDrag
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
            $0.trailing.equalTo(saveBtn.snp.leading).offset(0)
        }
        
        saveBtn.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
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

extension WriteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.tag == 111 {
            setPlaceholder()
        } else {
            setPlaceholder2()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            if textView.tag == 111 {
                setPlaceholder()
            } else {
                setPlaceholder2()
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text else { return true }
        if textView.tag == 111 {
            let newLength = str.count + text.count - range.length
            
            self.viewModel.model?.phrase = str
            self.bookCoverView.bind(color: self.viewModel.selColor, text: str)
            return newLength <= 32
        } else {
            self.viewModel.model?.reason = str
            return true
        }
    }
    
}
