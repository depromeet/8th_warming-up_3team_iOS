//
//  SearchBookViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/28.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx
import NMapsMap
import Kingfisher

class SearchBookViewController: UIViewController, ViewModelBindableType {
    var viewModel: WriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToExitBtn))
        exitImg.addGestureRecognizer(tapGesture)
        exitImg.isUserInteractionEnabled = true
    }
    
    func bindViewModel() {
        viewModel.booksData
            .bind(to: adderCollectionView.rx.items(cellIdentifier: String(describing: BooksCollectionCell.self), cellType: BooksCollectionCell.self)) { (_, element, cell) in
                // TODO: 캐시로 처리해
                cell.ivImageView.kf.setImage(with: URL(string: element.thumbnail ?? ""))
                cell.lbTitle.setTextWithLetterSpacing(text: element.title ?? "", letterSpacing: -0.08, lineHeight: 19, font: UIFont.systemFont(ofSize: 16, weight: .medium), color: ColorUtils.color34)
                cell.lbSubText.setFocusTextWithLetterSpacing(
                    text: "\(element.authors?.first ?? "") 지음  |  \(element.publisher ?? "")",
                    focusText: "|",
                    focusFont: UIFont(name: "AppleSDGothicNeo-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium) ,
                    focusColor: ColorUtils.color221,
                    letterSpacing: -0.06,
                    lineHeight: 13,
                    color: ColorUtils.color68
                )
                cell.lbDescription.setTextWithLetterSpacing(text: element.contents ?? "", letterSpacing: -0.06, lineHeight: 14, font: UIFont.systemFont(ofSize: 12, weight: .regular), color: ColorUtils.color136)
                cell.layoutIfNeeded()

                cell.lbTitle.lineBreakMode = .byTruncatingTail
                cell.lbSubText.lineBreakMode = .byTruncatingTail
                cell.lbDescription.lineBreakMode = .byTruncatingTail
        }
        .disposed(by: rx.disposeBag)
        
        Observable
            .zip(adderCollectionView.rx.itemSelected, adderCollectionView.rx.modelSelected(SearchBooks.self))
            .bind { [unowned self] _, selData in
                let dateFormatter = DateFormatter()
                let strDateFormatter = DateFormatter()
                strDateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.dateFormat = "yyyyMMdd"
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                let pubDate = selData.datetime?.split(separator: "T").first
            
                self.viewModel.model?.title = selData.title ?? ""
                self.viewModel.model?.thumbnail = selData.thumbnail ?? ""
                self.viewModel.model?.author = selData.authors?.first ?? ""
                self.viewModel.model?.pubDate = String(pubDate ?? "")
                self.viewModel.model?.publisher = selData.publisher ?? ""
                self.viewModel.model?.description = selData.contents ?? ""
                                
                self.viewModel.bookTitle.onNext(selData.title ?? "")
                self.navigationController?.popViewController(animated: true)
        }
        .disposed(by: rx.disposeBag)
    }
    
    let exitImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "btnClose24")
        return img
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 207, height: 18)
        label.text = "책 찾아보기"
        label.textAlignment = .center
        label.font = label.font.withSize(15)
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = ColorUtils.color247
        textView.textContainerInset = UIEdgeInsets(top: 11, left: 48, bottom: 10, right: 40)

        textView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textView.attributedText = TextUtils.attributedPlaceholder(text: "책 제목이나 작가를 찾아보세요.", letterSpacing: -0.07, aligment: .left)
        return textView
    }()
    
    let btnSearch: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "icnSearch24"), for: .normal)
        return b
    }()
    
    let btnDelete: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "btnDelete24"), for: .normal)
        return b
    }()
    
    let adderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 10, height: 34)
        layout.scrollDirection = .vertical
        let adderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        adderCollectionView.backgroundColor = .white
        adderCollectionView.showsVerticalScrollIndicator = false
        adderCollectionView.register(BooksCollectionCell.self, forCellWithReuseIdentifier: String(describing: BooksCollectionCell.self))
        
        return adderCollectionView
    }()
}

extension SearchBookViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            viewModel.searchProvider.rx
                .request(.book(title: textView.text))
                .filterSuccessfulStatusCodes()
                .map(BooksModel.self)
                .subscribe(onSuccess: { [unowned self] res in
                    self.viewModel.booksData.onNext(res.documents ?? [])
                }) { (err) in
                    print(err)
            }
            .disposed(by: rx.disposeBag)
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            setPlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            setPlaceholder()
        }
    }
    
    private func setPlaceholder() {
        if textView.text == "책 제목이나 작가를 찾아보세요." {
            textView.text = ""
            textView.typingAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium),
                NSAttributedString.Key.foregroundColor: ColorUtils.color34
            ]
        } else if textView.text == "" || textView.text.isEmpty {
            textView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            textView.attributedText = TextUtils.attributedPlaceholder(text: "책 제목이나 작가를 찾아보세요.", letterSpacing: -0.07)
        }
    }
}

extension SearchBookViewController {
    @objc func touchToExitBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        self.view.addSubview(exitImg)
        self.view.addSubview(titleLabel)
        self.view.addSubview(textView)
        self.textView.addSubview(btnSearch)
        self.textView.addSubview(btnDelete)
        self.view.addSubview(adderCollectionView)
        
        textView.delegate = self
        
        // TODO: 스냅킷 데모에서 사용하던데 이유는?
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
            $0.centerX.equalToSuperview()
        }
        
        textView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        btnSearch.snp.makeConstraints {
            $0.top.equalTo(textView.snp.top).offset(8)
            $0.leading.equalTo(textView.snp.leading).offset(12)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        // FIXME: 버튼 노출 안되네
        btnDelete.snp.makeConstraints {
            $0.top.equalTo(textView.snp.top).offset(8)
            $0.leading.equalTo(Dimens.deviceWidth * 0.94)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
            $0.bottom.equalTo(textView.snp.bottom).offset(-8)
        }
        
        adderCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(14)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
