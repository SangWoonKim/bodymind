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
- 3월 12일 기준
- 운동 기능 개발 1순위
- (운동 ui 제작 진행중, 운동ui 상세 진행 예정 - 이후 viewmodel 및 provider 작성 예정)
- 수면 기능 개발 2순위
- 홈화면 평가 및 제안 String 제작 및 enum화 3순위
- 블루투스를 통한 대화 기능 4순위
- 기타 - aos,ios common_mutiple_health 단위테스트는 성공했으나 데이터에 대한 빈값 데이터 생성 또는 미생성에 대한 이슈가 있을 수 있기에 우선 순위 변경 될 수 있음(aos 겔럭시 워치 데이터를 수신받기 시작한지 얼마 안되어서 병행진행) 


## developer info
email : rlatkddns031@gmail.com

## development info
flutter version 3.38.6

