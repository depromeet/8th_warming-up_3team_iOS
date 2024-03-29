# 8th_warming-up_3team_iOS
iOS project 

### TODO 

기환이가 API 작업해주기로 함 😍     
  21. 3. 14 재개를 위한 사전 준비

- [ ] 기획적인 부분 담당은 누구?
- [ ] 추가적인 디자인은 누구 해줄거임? (정안?, 보영?)
- [ ] API를 위한 비즈니스 로직 정리 (비즈니스 로직 작성하던거 어딧?)

이전 서버 레포
https://github.com/depromeet/toward-book-server 


---------

## 북쪽으로 - 마음을 움직이는 책을 따라서

[toc]

#### 앱 기본 구조

MVVM + Coordinator

- ViewModel의 의존성 주입은 클래스 생성 시 이전 클래스에서


검색 주소 API : 네이버 지도 - Geocoding
https://docs.ncloud.com/ko/naveropenapi_v3/maps/geocoding/geocoding.html

상호 주소 API : 카카오 로컬 - 키워드 검색
https://developers.kakao.com/docs/latest/ko/local/common

책 검색 API : 아직 백엔드 -> 전환해야함 
https://developers.kakao.com/docs/latest/ko/daum-search/dev-guide#search-book




#### 구현 방법?

- View init - 클로저 초기화

  ```swift
  let profileCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.sectionInset = .zero
          layout.minimumLineSpacing = 5
          layout.minimumInteritemSpacing = 0
          layout.itemSize = CGSize(width: 84, height: 106)
          layout.scrollDirection = .vertical
          let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          profileCollectionView.backgroundColor = .clear
          profileCollectionView.register(ProfileCollectionCell.self, forCellWithReuseIdentifier: String(describing: ProfileCollectionCell.self))
          return profileCollectionView
      }()
  ```

-----

#### 사용된 라이브러리

   - SnapKit

     ```
     기본 Anchor만 쓰다보니.. 한번 써보고 싶어서 씀
     ```

   - Moya/RxSwift

     ```
     observable.create 감싸서 하는 것보다 
     한방에 API 응답 데이터를 옵저버블로 쓸려고 
     ```

   - Hero

     ```
     화려한 화면 전환 애니메이션을 위하여 - 어따 쓰지?
     ```

   - SwiftLint

     ```
     규칙 규칙
     ```

   - NMapsMap

     ```
     네. 우리 앱 지도 기반 ㄱㅅ
     ```

   - FireStroe 

     ```
     백엔드 없이 처리하기 위해 사용
     ```
     
- FirebaseDatabase

  ```
  반경 내 위치 정보를 가져오기 위해서 FireStroe 대신 사용
  ```

- GeoFire

  ```swift
  아래 쿼리로 FirebaseDatabase == 리얼타임 디비에서
  데이터를 가져올 수 있다고 하는데 테스트가 필요
  geoFire.queryAtLocation(center, withRadius: 0.6)
  ```

   - Action

     ```
     이벤트를 추상화하고 리액티브하게 쓰는데...
     좋은데 와닿지 않음 아직은 왜..? 
     Action<Input, Element>
     CocoaAction = Action<Void, Void>
     ```

   - NSObject+Rx

     ```
     NSObject를 채택하는 클래스에서 별도의 disposeBag 선언 없이 "rx.disposeBag" 사용할 수 있음
     ```

--------------------
--------------------
--------------------
--------------------

#### 테스트플라이트 1.04 피드백

- [ ]  더미 이미지 깔린거 빼주시면 감사하겠습니닷...!
   Bg이미지 바로 위에 로티 얹어주시면

- [ ] FireStroe GeoPoint distance 계산이 올바르지 않아
  아래와 같이 문제 됨

  1.한강에 글 남김
  2.울집이랑 한강이랑 먼데 책이 모달창에 뜸
  3.한강쪽으로 지도 움직이니까 똑같은 책이 한개씩 증가

- [ ] 그리고 기록하기 페이지에서는 괜찮은데 북커버에 최종으로 표출되는 내용이 본문내용이에요! > 타이틀이 노출되어야함

  

#### 테스트플라이트 1.01 피드백

- [x] 스플래쉬 화면 - 로티 작동안함
  ➡️ after 2초 뒤에 화면 이동
- [x] 로그인 화면 - 로티 작동 안함
  ➡️ 위에 처리하니깐 동작한 뭔가 임포트 로딩문제
- [ ] 온보딩 화면 - 버튼 모두 활성화 처리
  ➡️  이건 쫌 이야기 해보고
- [ ] 메인화면 - 프로필 그림자 값 확인
- [ ] 메인화면 - 책 리스트 상단 R값 12 확인
- [ ] 메인화면 - 글쓰기 버튼 그림자 확인
- [ ] 메인화면 - 모든 시간 빼고, 태그 선택 컬러 확인
- [ ] 글쓰기 - 태그 선택 후 클릭 시 해제 되도록
- [ ] 글쓰기 - 최초 랜딩 시 "감상니나, 감명 깊었던 문구를 적어주세요" 노출 해야함
- [x] 글쓰기 - 책 선택 시 책 제목 필드에 노출되어야함
  ➡️ 책 제목, 위치 매핑 되도록 수정함
- [ ] 글쓰기 - 글쓰는 부분, 키보드에 퀵버튼(닫기) 달기
- [ ] 글쓰기 - 태그 부분 양쪽 정렬 말고 좌측정렬

