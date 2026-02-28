# bodymind
common_mutiple_health으로 명명된 직접 제작한 flutter native간 bridge 모듈을 이식하여 구현중인 
건강관리 어플리케이션입니다.

## convention
- file name : snakeCase,
- varient & class name : camel_case
- enum : lowercase,

- design pattern : MVVM (최대한...)
- indent : tab
- name role : class(folder + feature + role) 

folder structure 
feature
  - dtl/feature
    - data
      - model
      - repository
    - domain
      - entity
      - repository
      - usecase
    - presentaion
      - view
      - viewmodel


## 주의사항
이 프로젝트는 clone하더라도 실행이 불가합니다.
직접제작된 common_mutiple_health 모듈에 대한 의존성을 주입받을 수 없으시기에 작동될 수 없습니다.
만약 클론 후 빌드 하실 경우 개발자에게 문의하시기 바랍니다.

## 이슈사항
- 2월 28일 기준
- act 화면 제작 진행중입니다.
- act usecase 주차별 데이터 바인딩 안되는 현상 수정 진행 예정입니다. 1순위
- act graph view 수정 진행 예정입니다. 2순위
- 메인 페이지에서 각 데이터 유형 grid 터치 영역 확장 예정입니다. 3순위
- 초기 실행시 router쪽에서 redirect가 안되는 현상이 있습니다.(원인: isUserRegistered값이 변경되지 않음 - 회원정보 입력시 insert후 해당 상태이 변경이 가능하도록 watch로 작업하여 observing하거나 또는 주입을 통한 갱신 로직 작성 예정) 4순위
- 아직 앱 바쪽은 개발중입니다. 다만 우선순위 밖이라 이후 할 예정입니다. 5순위
- 운동 기능 개발 6순위

## developer info
email : rlatkddns031@gmail.com

## development info
flutter version 3.38.6

