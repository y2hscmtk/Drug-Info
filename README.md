# 이게뭐약?(Drug-Info)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fy2hscmtk%2FDrug-Info&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

이게뭐약?은 공공데이터 포탈 오픈 API [식품의약품안전처_의약품개요정보(e약은요)](https://www.data.go.kr/data/15075057/openapi.do)를 사용하여 제작한 알약 효능 검색 및 저장 어플리케이션입니다.

이 어플리케이션을 사용해서 사용자는 병의 증세(두통, 복통,등)로 알약을 검색하고, '나의 약통'에 저장하여 필요할 때 찾아볼 수 있습니다.

## 1. 회원가입 / 로그인

<p float="left">
  <img src="https://github.com/600GramsMarket/HangeunMarket/assets/109474668/22d85575-68b4-45a5-8a45-81aa1a042189" width="200"/>
  <img src="https://github.com/600GramsMarket/HangeunMarket/assets/109474668/b387d1fb-b605-46c0-be38-5b277265978d" width="200"/>
  <img src="https://github.com/600GramsMarket/HangeunMarket/assets/109474668/0637121d-28e5-4626-bbf9-86c41ffc6dd9" width="200"/> 
  <img src="https://github.com/600GramsMarket/HangeunMarket/assets/109474668/49f9eb57-a5ca-43cd-8937-bd4f0c9cb724" width="200"/>
</p>

- Email / Password를 이용한 회원가입
  - 사용자로부터 Email, Password 를 입력받아 회원가입을 진행합니다.
  - 회원가입은 `Firebase Authentication`를 통해 이루어지며, 사용자 정보는 `Firebase Realtime Database`에 저장됩니다.
  
- Email / Password를 이용한 로그인
  - `Firebase Authentication`를 이용하여 사용자가 입력한 이메일과 비밀번호가 유효한지 확인 후, 로그인을 승인합니다.

https://github.com/y2hscmtk/Drug-Info/assets/109474668/7251305a-1284-4979-9d81-8a76ebdc9759

## 2. 알약 검색 / 정보 보기

<p float="left">
  <img src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/8ba13a94-4766-4f7b-ae52-d229cf0f2474" width="200"/>
  <img src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/b4c472bb-e2e0-4b3b-8338-3b6fbe6c344b" width="200"/>
  <img src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/ae6c9a14-0eb3-46b5-bbbc-e9c64e28cac8" width="200"/>
</p>

- 알약 검색
  - 사용자가 병세를 검색하면 공공 데이터 포탈 API를 활용하여 해당 병세에 알맞은 알약을 검색하여 보여줍니다.(최대 15개를 검색하여 반환합니다.)
  
- 알약 상세 정보 보기
  - 검색결과를 클릭하면 알약에 대한 상세한 정보를 제공합니다. 제공하는 정보는 알약 이름, 제조사, 알약 효능, 복용 방법, 보관 방법이 있습니다.

https://github.com/y2hscmtk/Drug-Info/assets/109474668/966ab9b0-3880-478b-b15c-428bafe75b98


## 3. 알약 저장 / 저장한 알약 조회

<p float="left">
  <img src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/44d42deb-e780-4c22-98e8-28a129e9a61b" width="200"/>
  <img src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/a74b180b-ff01-4d1b-9d0f-02182610c8ab" width="200"/>
  <img src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/15c9ad9f-4d83-46ae-ab7d-546e201549a0" width="200"/>
  <img src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/dd17644d-a9e1-4259-9784-14dd486278f2" width="200"/>
</p>

- 알약 저장
  - 알약 상세 정보 보기 페이지에서 저장 버튼을 클릭하여 알약을 저장할 수 있습니다.
  - 저장한 알약은 `Firebase Realtime Database`를 통해 `나의 약통`에 저장됩니다. 
  
- 저장한 알약 조회
  - `나의 약통` 페이지에서 저장한 알약의 이미지를 모아 볼 수 있습니다. 이 기능을 통해 사용자는 매번 검색할 필요없이 원하는 정보를 확인할 수 있습니다. 

https://github.com/y2hscmtk/Drug-Info/assets/109474668/8fcd4129-0464-4739-b846-87af13dd2d76

> [!IMPORTANT]
> 어플리케이션을 실행하기 전, Secrets.json파일을 생성한뒤 API키를 발급받아 등록하여야합니다.

<img width="729" alt="image" src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/c7d4f5a1-87e2-4aa0-b38c-f7c19927a6ac">
<img width="731" alt="image" src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/8d458f3b-3373-4097-b7e5-96adb485d927">
<img width="561" alt="image" src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/a8661aba-28f5-45b2-8424-51c47961c2df">  

API키는 Decode키를 등록해야 합니다.  
<img width="516" alt="image" src="https://github.com/y2hscmtk/Drug-Info/assets/109474668/dffd8f26-95f1-4254-bf84-c255e1a82e28">

> [!IMPORTANT]
> 파이어베이스 .plist 파일을 추가하지 않으면 어플리케이션이 정상 작동하지 않습니다.
파이어베이스 콘솔을 생성하고 Authentication과 RealtimeDatabase를 활성화 시켜주세요.


<br><br>
## 🔨Used Skill
<p>
  <img src="https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/Xcode-147EFB?style=flat-square&logo=Xcode&logoColor=white"/>
  <img src="https://img.shields.io/badge/firebase-FFCA28?style=flat&logo=firebase&logoColor=white"/>
</p>
