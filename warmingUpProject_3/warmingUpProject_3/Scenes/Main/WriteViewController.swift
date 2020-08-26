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
    
    let writeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        colorListCollectionView.contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 12, right: 20)
        colorListCollectionView.backgroundColor = .yellow
        colorListCollectionView.showsHorizontalScrollIndicator = false
        colorListCollectionView.register(ColorCollectionCell.self, forCellWithReuseIdentifier: String(describing: ColorCollectionCell.self))
        
        
        return colorListCollectionView
    }()
    
    let bookTitleView: UIView = {
        let bookTitle = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "책 제목"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        let searchBtnView = UIButton()
        searchBtnView.setTitle("찾아보기 >", for: .normal)
        searchBtnView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        searchBtnView.setTitleColor(ColorUtils.color170, for: .normal)
        
        bookTitle.addSubview(titleLabel)
        bookTitle.addSubview(searchBtnView)
        bookTitle.backgroundColor = .clear
        
        bookTitle.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bookTitle.snp.leading).offset(20)
            $0.top.equalTo(bookTitle.snp.top).offset(20)
            $0.height.equalTo(17)
        }
        
        searchBtnView.snp.makeConstraints {
            $0.trailing.equalTo(bookTitle.snp.trailing).offset(-20)
            $0.top.equalTo(bookTitle.snp.top).offset(20)
            $0.height.equalTo(17)
        }
        return bookTitle
    }()
    
    
    let locationView: UIView = {
        let locationTitle = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "기록을 남길 위치"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        let selectBtnView = UIButton()
        selectBtnView.setTitle("선택하기 >", for: .normal)
        selectBtnView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        selectBtnView.setTitleColor(ColorUtils.color170, for: .normal)
        
        locationTitle.addSubview(titleLabel)
        locationTitle.addSubview(selectBtnView)
        locationTitle.backgroundColor = .clear
        
        locationTitle.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(locationTitle.snp.leading).offset(20)
            $0.top.equalTo(locationTitle.snp.top).offset(20)
            $0.height.equalTo(17)
        }
        
        selectBtnView.snp.makeConstraints {
            $0.trailing.equalTo(locationTitle.snp.trailing).offset(-20)
            $0.top.equalTo(locationTitle.snp.top).offset(20)
            $0.height.equalTo(17)
        }
        return locationTitle
    }()
    
    let writeBookcoverView: UIView = {
        let bookcoverView = UIView()
        let selectBtnView = UIButton()
        selectBtnView.setTitle("북커버에 남길 감상이나 문구를 적어주세요 (32자)", for: .normal)
        selectBtnView.setTitleColor(ColorUtils.color170, for: .normal)
        selectBtnView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        bookcoverView.addSubview(selectBtnView)
        bookcoverView.backgroundColor = .clear
        
        bookcoverView.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        selectBtnView.snp.makeConstraints {
            $0.leading.equalTo(bookcoverView.snp.leading).offset(20)
            $0.top.equalTo(bookcoverView.snp.top).offset(20)
            $0.height.equalTo(17)
        }
        return bookcoverView
    }()
    
    let bookCommentView: UIView = {
        let commentView = UIView()
        let selectBtnView = UIButton()
        selectBtnView.setTitle("이 책을 이 위치에 남기는 이유를 알려주세요.", for: .normal)
        selectBtnView.setTitleColor(ColorUtils.color170, for: .normal)
        selectBtnView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        commentView.addSubview(selectBtnView)
        commentView.backgroundColor = ColorUtils.color247
        
        commentView.snp.makeConstraints {
            $0.height.equalTo(146)
            $0.leading.equalTo(commentView.snp.leading).offset(20)
            $0.top.equalTo(commentView.snp.top).offset(14)
        }
        
        selectBtnView.snp.makeConstraints {
            $0.leading.equalTo(commentView.snp.leading).offset(20)
            $0.top.equalTo(commentView.snp.top).offset(20)
            $0.height.equalTo(17)
        }
        return commentView
    }()
    
    let suggestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 10, height: 34)
        layout.scrollDirection = .horizontal
        let suggestListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        suggestListCollectionView.contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 12, right: 20)
        suggestListCollectionView.backgroundColor = .white
        suggestListCollectionView.showsHorizontalScrollIndicator = false
        suggestListCollectionView.register(RoundCollectionCell.self, forCellWithReuseIdentifier: String(describing: RoundCollectionCell.self))
        return suggestListCollectionView
    }()
    
//    let tagCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = .zero
//        layout.minimumLineSpacing = 7
//        layout.minimumInteritemSpacing = 0
//        layout.estimatedItemSize = CGSize(width: 10, height: 34)
//        layout.scrollDirection = .horizontal
//        let tagListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        tagListCollectionView.contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 12, right: 20)
//        tagListCollectionView.backgroundColor = .white
//        tagListCollectionView.showsHorizontalScrollIndicator = false
//        tagListCollectionView.register(RoundCollectionCell.self, forCellWithReuseIdentifier: String(describing: RoundCollectionCell.self))
//        return tagListCollectionView
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToExitBtn))
        setUI()
        exitImg.addGestureRecognizer(tapGesture)
        exitImg.isUserInteractionEnabled = true
        
    }
    
    func bindViewModel() {
        viewModel.success.bind(to: colorListCollectionView.rx.items(cellIdentifier: String(describing: ColorCollectionCell.self), cellType: ColorCollectionCell.self)) { (row, element, cell) in
            cell.lbRoundText.setTextWithLetterSpacing(text: element, letterSpacing: -0.06, lineHeight: 20)
            
        }.disposed(by: rx.disposeBag)
        
        viewModel.suggest.bind(to: suggestCollectionView.rx.items(cellIdentifier: String(describing: RoundCollectionCell.self), cellType: RoundCollectionCell.self)) { (row, element, cell) in
                   cell.lbRoundText.setTextWithLetterSpacing(text: element, letterSpacing: -0.06, lineHeight: 20)
                   
               }.disposed(by: rx.disposeBag)
        
//        viewModel.suggest.bind(to: tagCollectionView.rx.items(cellIdentifier: String(describing: RoundCollectionCell.self), cellType: RoundCollectionCell.self)) { (row, element, cell) in
//            cell.lbRoundText.setTextWithLetterSpacing(text: element, letterSpacing: -0.06, lineHeight: 20)
//
//        }.disposed(by: rx.disposeBag)
    }
    
}

extension WriteViewController {
    
    @objc func touchToExitBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        scrollView.backgroundColor = .systemGray
        self.view.addSubview(exitImg)
        self.view.addSubview(titleLabel)
        self.view.addSubview(saveBtn)
        self.view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        scrollView.addSubview(writeView)
        writeView.addSubview(colorListCollectionView)
        writeView.addSubview(bookTitleView)
        writeView.addSubview(locationView)
        writeView.addSubview(writeBookcoverView)
        writeView.addSubview(bookCommentView)
        writeView.addSubview(suggestCollectionView)
//        writeView.addSubview(tagCollectionView)
//
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
//
        writeView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.height.equalTo(800)
            $0.top.equalTo(mainView.snp.bottom)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }
//
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
        
        locationView.snp.makeConstraints {
            $0.top.equalTo(bookTitleView.snp.bottom)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(55)
        }
        
        writeBookcoverView.snp.makeConstraints {
            $0.top.equalTo(locationView.snp.bottom)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(55)
        }
        
        bookCommentView.snp.makeConstraints {
            $0.top.equalTo(writeBookcoverView.snp.bottom)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(160)
        }
        
        suggestCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookCommentView.snp.top)
            $0.leading.equalTo(writeView.snp.leading)
            $0.trailing.equalTo(writeView.snp.trailing)
            $0.height.equalTo(62)
        }
    
//        tagCollectionView.snp.makeConstraints {
//            $0.top.equalTo(suggestCollectionView.snp.top)
//            $0.leading.equalTo(writeView.snp.leading)
//            $0.trailing.equalTo(writeView.snp.trailing)
//            $0.height.equalTo(136)
//        }
    }
}
