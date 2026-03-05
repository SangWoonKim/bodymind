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
- 3월 3일 기준
- 중간 이슈사항 수정 예정입니다.
- aos common_mutiple_health 모듈 이슈 수정중입니다. (처음 테스트 해봄 - 날짜 이슈 및 권한, 빈 데이터 생성) 이후 act쪽 빈데이터 생성을 통해 ui 그래프 일치 안되는 현상 수정 예정입니다. 1순위
- 아직 앱 바쪽은 개발중입니다. 다만 우선순위 밖이라 이후 할 예정입니다. 2순위
- 운동 기능 개발 3순위
- 수면 기능 개발 4순위

## developer info
email : rlatkddns031@gmail.com

## development info
flutter version 3.38.6

