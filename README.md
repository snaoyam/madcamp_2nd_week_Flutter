# cs496_1stWeek
> 2022 여름 MadCamp 2분반 문동우, 이영준 팀
## 프로젝트 이름
```
Mad Promo
```
## 팀원
* 성균관대 컴퓨터교육과 [이영준](https://github.com/leeyjwinter)
* KAIST 전산학부 [문동우](https://github.com/snaoyam)
## 개발 환경
* OS: Android, ios (targetSdk: flutter.targetSdkVersion)
* Language: Kotlin, NodeJs, Mongodb
* IDE: Android Studio, Visual Studio Code

## 프로젝트 소개
### 시작 화면: Login
![](https://velog.velcdn.com/images/leeyjwinter/post/b90f07c9-9b32-4a22-ab42-f4b57606008c/image.png)

* 시작화면에서 로그인 창이 나오며 카카오 혹은 이메일을 통하여 로그인 및 회원가입을 할 수 있다.
* 카카오로 로그인을 누르면 권한 창이 나오며 로그인을 완료하여 홈 탭으로 들어갈 수 있다.

### TAB 1: 홈


* 휴대전화에 저장된 모든 연락처를 조회할 수 있다.
* 앱을 처음 열면 연락처 접근(READ_CONTACTS) 및 전화 걸기(CALL_PHONE) 권한을 묻는 창을 띄운다.
* 주소록에 접근해 저장된 사진과 이름, 전화번호를 가져와 RecyclerView로 보여준다.
* 연락처 옆의 전화 버튼을 눌러 그 번호로 전화를 걸 수 있다.
### TAB 2: 도전과제
!![](https://velog.velcdn.com/images/leeyjwinter/post/bed1e1f4-1f50-40f4-8128-887ed2ce2af2/image.png)

* 사용자의 프로젝트 등록 수, 프로젝트의 조회 수를 통하여 도전과제 달성 여부를 알려준다.
* 일정 도전과제 조건을 만족하면 도전과제 카드의 색이 밝게 들어와 사용자가 자신의 도전과제 달성 여부를 확인할 수 있도록 해준다. 
### TAB 3: 내 정보와 로그아웃

![](https://velog.velcdn.com/images/leeyjwinter/post/ef6a3746-0308-45f5-869f-4824bdc4320e/image.png)

* 내 정보로 들어가 Username, Email, Score을 확인할 수 있고, Logout 버튼을 통하여 로그아웃을 수행할 수 있다.
* Score은 프로젝트 개수로 계산한다.
* Username, Email, Score의 세 리스트를 버튼으로 하여 누르면 정보가 보여지도록 하였다. 
* 로그아웃 버튼을 누르면 첫번 째의 로그인 창으로 돌아오며, 카카오톡이던, 메일을 통해 로그인을 했던지 모두 로그아웃 처리로 된다.

### ++ 로딩중 
![업로드중..](blob:https://velog.io/20a12691-ece1-4cee-b170-4843599fee17)
* 로그인이나 로그아웃 같이 구동 시간이 걸리는 작업에서는 사이사이에 loading page를 넣어 사용성을 강화했다. 
