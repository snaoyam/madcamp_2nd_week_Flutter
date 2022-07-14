# cs496_2ndWeek
> 2022 여름 MadCamp 2분반 문동우, 이영준 팀
## 프로젝트 이름
```
프로포폴
```
## 팀원
* KAIST 전산학부 [문동우](https://github.com/snaoyam)
* 성균관대 컴퓨터교육과 [이영준](https://github.com/leeyjwinter)

## 개발 환경
* OS: Android, ios (targetSdk: flutter.targetSdkVersion)
* Language: Kotlin, NodeJs, Mongodb
* IDE: Android Studio, Visual Studio Code

## 프로젝트 소개!

### 시작 화면: Login 및 회원가입

로그인 화면                   |  이메일 회원가입              | 이메일 로그인                | 카카오 로그인
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![pic1-1](https://user-images.githubusercontent.com/93732046/178928686-3e5b2570-da4f-4e7b-99d5-40c64fdc366f.png) | ![pic1-2](https://user-images.githubusercontent.com/93732046/178927548-11b86a79-beb7-4ea4-827c-d33b7110b583.png) | ![pic1-3](https://user-images.githubusercontent.com/93732046/178928322-6f295137-db0d-4637-9b5d-f920b83562f5.png) | ![pic1-4](https://user-images.githubusercontent.com/93732046/178928720-e6dfb609-91f9-4776-8819-18bd069621f0.png)

* 시작화면에서 로그인 창이 나오며 카카오 혹은 이메일을 통하여 로그인 및 회원가입을 할 수 있다.
* 카카오로 로그인을 누르면 권한 창이 나오며 로그인을 완료하여 홈 탭으로 들어갈 수 있다.
* Register as New Email User을 터치한다면 회원가입 창으로 넘어가며,
* 여기서 이름, 몰입캠프 수강시기, 분반, 이메일 등의 정보를 주어 회원가입을 하고, 로그인을 할 수 있다.

### TAB 1: 홈
  등록된 포스트 조회           |  개별 포스트 조회             | 새 포스트 업로드        
:-------------------------:|:-------------------------:|:-------------------------:
![pic2-2](https://user-images.githubusercontent.com/93732046/178929520-f973d645-43f7-4b02-a768-107bdeed0831.png) | ![pic2-3](https://user-images.githubusercontent.com/93732046/178929716-88884481-2b10-4295-9063-870fa6bb3a68.png) | ![pic2-1](https://user-images.githubusercontent.com/93732046/178929440-33ae1025-a11e-4c8e-8d35-af90c3c69384.png)

* 홈 탭에서는 사용자들이 업로드한 프로젝트 홍보물들을 확인할 수 있다.
* 사용자가 원한다면 + 버튼을 눌러 프로젝트 등록하기 폼을 열 수 있다.
* 여기서 프로젝트 이름, github 링크, 그리고 부가 설명을 달아준 후 업로드를 한다.
* 프로젝트 리스트 항목 중 하나를 터치하면 사용자가 등록한 정보와 깃허브 링크의 readme 파일을 자동으로 불러와 사용자에게 보여준다.

### TAB 2: 도전과제
도전과제 페이지
:-------------------------:
![pic3](https://user-images.githubusercontent.com/93732046/178929990-0a3b3923-8b0a-4e33-bc83-4f852d3687a0.png)

* 사용자의 프로젝트 등록 수, 프로젝트의 조회 수를 통하여 도전과제 달성 여부를 알려준다.
* 일정 도전과제 조건을 만족하면 도전과제 카드의 색이 밝게 들어와 사용자가 자신의 도전과제 달성 여부를 확인할 수 있도록 해준다. 
### TAB 3: 내 정보와 로그아웃
내 정보 확인 페이지             | 숨겨진 정보 확인
:-------------------------:|:-------------------------:
![pic3-1](https://user-images.githubusercontent.com/93732046/178930383-90feca69-f14a-42cc-a3aa-6ef8a08cef95.png) | ![pic3-2](https://user-images.githubusercontent.com/93732046/178930400-66abbbb4-550d-4ca7-be35-0d65fde7b8de.png)

* 내 정보로 들어가 Username, Email, Score을 확인할 수 있고, Logout 버튼을 통하여 로그아웃을 수행할 수 있다.
* Score은 프로젝트 개수로 계산한다.
* Username, Email, Score의 세 리스트를 버튼으로 하여 누르면 정보가 보여지도록 하였다. 
* 로그아웃 버튼을 누르면 첫번 째의 로그인 창으로 돌아오며, 카카오톡이던, 메일을 통해 로그인을 했던지 모두 로그아웃 처리로 된다.

### 로딩중 화면
앱 시작 로딩                  | 포스트 로딩                 | README.md 로딩
:-------------------------:|:-------------------------:|:-------------------------:
![pic4-1](https://user-images.githubusercontent.com/93732046/178931249-01cd85c3-2f7c-4b20-bb5a-d3909288eea3.png) | ![pic4-2](https://user-images.githubusercontent.com/93732046/178931256-1fc98edb-b411-4733-93fe-1755c361e5dc.png) | ![pic4-3](https://user-images.githubusercontent.com/93732046/178931264-0205ccdc-e289-48de-af0d-db4ba4c8709c.png)

* 로그인이나 로그아웃 같이 구동 시간이 걸리는 작업에서는 사이사이에 loading page를 넣어 사용성을 강화했다. 
* 시작 로딩은 Progress bar, 포스트 및 MD 파일 로딩의 경우 Shimmer loading effect를 사용하였다.
