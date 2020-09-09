//
//  OnBoardExplanationViewController.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit
import SnapKit
import Action
import Lottie
import FirebaseFirestore
import FirebaseFirestoreSwift

class OnBoardExplanationViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: OnBoardExplanationViewModel!
    
    let ivQuotes: UIImageView = {
        let ivQuotes = UIImageView()
        ivQuotes.image = UIImage(named: "icnDoubleQuotes")
        
        return ivQuotes
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var btnNext: UIButton = {
        let btnNext = UIButton(type: .custom)
        btnNext.setTitleColor(.white, for: .normal)
        btnNext.setTitleColor(.white, for: .selected)
        btnNext.setBackgroundColor(#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1), for: .normal)
        btnNext.setBackgroundColor(UIColor(r: 84, g: 90, b: 124), for: .selected)
        btnNext.titleEdgeInsets.top = -Dimens.getSafeAreaBottomMargin() - 17
        btnNext.setAttributedTitle(TextUtils.textLetterSpacingAttribute(text: "다음", letterSpacing: -0.09, color: .white, font: UIFont.systemFont(ofSize: 18, weight: .medium) ), for: .normal)
        btnNext.setAttributedTitle(TextUtils.textLetterSpacingAttribute(text: "시작합니다", letterSpacing: -0.09, color: .white, font: UIFont.systemFont(ofSize: 18, weight: .medium) ), for: .selected)
        return btnNext
    }()
    
    override func loadView() {
        super.loadView()
        setUI()
    }
    
    override func viewDidLoad() {
        print("######### OnBoardingViewController ")
    }
    
    func bindViewModel() {
        btnNext.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [unowned self]_ in
                if self.btnNext.isSelected {
                    self.viewModel.nextAction()
                }
            })
            .disposed(by: rx.disposeBag)
        
        //            .action = viewModel?.nextAction()
    }
    
}

//MARK: private 메소드
extension OnBoardExplanationViewController {
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(ivQuotes)
        self.view.addSubview(scrollView)
        self.view.addSubview(btnNext)
        //TODO: 스냅킷 데모에서 사용하던데 이유는?
        self.view.setNeedsUpdateConstraints()
        setLayout()
        setScrollView()
    }
    
    private func setLayout() {
        ivQuotes.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(96)
            make.centerX.equalToSuperview().offset(-1)
            make.height.equalTo(24)
            make.width.equalTo(30)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(ivQuotes.snp.bottom).offset(22)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(btnNext.snp.top)
        }
        
        btnNext.snp.makeConstraints { (make) in
            var bottom: CGFloat = 0
            if #available(iOS 13.0, *) {
                bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0.0
            } else {
                bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
            }
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(74 + Dimens.getSafeAreaBottomMargin())
            make.bottom.equalToSuperview()
        }
    }
    
    private func setScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        addPageToScrollView(with: viewModel.lotties)
        
    }
    
    private func addPageToScrollView(with lotties: [String]) {
        for (idx, lottie) in lotties.enumerated() {
            let lbTitle = UILabel()
            let lbSubTitle = UILabel()
            let animation = Animation.named(lottie)
            let lottieView = AnimationView(animation: animation)
            let lbIndicator = UILabel()
            
            scrollView.contentSize = CGSize(width: Dimens.deviceWidth * CGFloat(lotties.count), height: scrollView.bounds.height)
            
            lbTitle.frame.size = CGSize(width: Dimens.deviceWidth - 100, height: Dimens.deviceHeight * 0.07389)
            lbTitle.frame.origin = CGPoint(x: Dimens.deviceWidth * CGFloat(idx) + 50, y: 0)
            lbTitle.numberOfLines = 0
            lbTitle.textAlignment = .center
            
            lbSubTitle.frame.size = CGSize(width: Dimens.deviceWidth - 100, height: Dimens.deviceHeight * 0.05172)
            lbSubTitle.frame.origin = CGPoint(x: Dimens.deviceWidth * CGFloat(idx) + 50, y: lbTitle.frame.maxY + 24)
            lbSubTitle.numberOfLines = 0
            lbSubTitle.textAlignment = .center
            
            lottieView.frame.size = CGSize(width: Dimens.deviceWidth,
                                           height: Dimens.deviceHeight * 0.32111)
            lottieView.frame.origin = CGPoint(x: Dimens.deviceWidth * CGFloat(idx), y: lbSubTitle.frame.maxY + 48)
            
            lbIndicator.frame.size = CGSize(width: Dimens.deviceWidth, height: Dimens.deviceHeight * 0.02333)
            lbIndicator.frame.origin = CGPoint(x: Dimens.deviceWidth * CGFloat(idx), y: lottieView.frame.maxY + 25)
            lbIndicator.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            lbIndicator.textColor = UIColor(r: 84, g: 90, b: 124)
            lbIndicator.textAlignment = .center
            
            self.scrollView.addSubview(lottieView)
            self.scrollView.addSubview(lbTitle)
            self.scrollView.addSubview(lbSubTitle)
            self.scrollView.addSubview(lbIndicator)
            
            switch idx {
            case 0:
                lbTitle.setTextWithLetterSpacing(text: "특별한 장소에\n의미있는 책을 남기세요.", letterSpacing: -0.1, lineHeight: 30, font: UIFont(name: TextUtils.FontType.NanumMyeongjoRegular.rawValue, size: 20) ?? UIFont.systemFont(ofSize: 20), color: ColorUtils.color34)
                lbSubTitle.setTextWithLetterSpacing(text: "책과 어울리는 거리, 독서하기 좋은 카페,\n주인공이 울고 웃던 바로 그 장소까지.", letterSpacing: -0.08, lineHeight: 21, font: UIFont.init(name: "AppleSDGothicNeo-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .medium), color: ColorUtils.color170)
                lbIndicator.setTextWithLetterSpacing(text: "1/3", letterSpacing: -0.08, lineHeight: 19)
            case 1:
                
                lbTitle.setTextWithLetterSpacing(text: "당신의 독서 발자취를\n한 눈에 확인하세요..", letterSpacing: -0.1, lineHeight: 30, font: UIFont(name: TextUtils.FontType.NanumMyeongjoRegular.rawValue, size: 20) ?? UIFont.systemFont(ofSize: 20), color: ColorUtils.color34)
                lbSubTitle.setTextWithLetterSpacing(text: "읽은 책은 책장에 예쁘게 꽂히고\n함께 남긴 장소는 지도에 차곡차곡.", letterSpacing: -0.08, lineHeight: 21, font: UIFont.init(name: "AppleSDGothicNeo-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .medium), color: ColorUtils.color170)
                lbIndicator.setTextWithLetterSpacing(text: "2/3", letterSpacing: -0.08, lineHeight: 19)
            case 2:
                lbTitle.setTextWithLetterSpacing(text: "이제, 마음을 움직이는\n책을 따라가보세요..", letterSpacing: -0.1, lineHeight: 30, font: UIFont(name: TextUtils.FontType.NanumMyeongjoRegular.rawValue, size: 20) ?? UIFont.systemFont(ofSize: 20), color: ColorUtils.color34)
                lbSubTitle.setTextWithLetterSpacing(text: "지도 위, 누군가 남긴 소중한 책과\n보물같은 장소를 찾는 순간.", letterSpacing: -0.08, lineHeight: 21, font: UIFont.init(name: "AppleSDGothicNeo-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .medium), color: ColorUtils.color170)
                lbIndicator.setTextWithLetterSpacing(text: "3/3", letterSpacing: -0.08, lineHeight: 19)
                
            default:
                break
            }
            lottieView.loopMode = .loop
            lottieView.play()
        }
    }
}

extension OnBoardExplanationViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // fmod = 벡터값을 나눔
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
            print(currentPage)
            
            if currentPage == 2 {
                btnNext.isSelected = true
            } else {
                btnNext.isSelected = false
            }
        }
    }
}
