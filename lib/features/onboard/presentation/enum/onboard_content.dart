import 'dart:ui';

enum OnboardContent{
  first('assets/images/onboard/onboard_first_two.png', '몸과 마음을 같이 돌보는 시간', '헬스데이터는 보기 쉽게 점수로,\n 오늘은 가까운 누군가의 응원으로 채워요.',null, '다음', Color(0xFFEFF6FF)),
  second('assets/images/onboard/onboard_second.png', '기록은 자동으로 모이고', '헬스커넥트·애플 건강 데이터를 가져와\n오늘의 상태를 정리해요.','입력 없이도 충분히 이해할 수 있게.', '다음', Color(0xFFFAF5FF)),
  third('assets/images/onboard/onboard_third.png', '오늘의 컨디션을 점수로 한눈에', '나이·성별·키·몸무게를 반영해\n유형별 점수와 종합 점수를 보여줘요.','어제보다 1%만 더 좋아도 충분해요.', '다음', Color(0xFFEEF2FF)),
  fourth('assets/images/onboard/onboard_fourth.png', '숫자보다 중요한 건 흐름','그래프로 변화 패턴을 확인하고,\n 내 리듬을 찾을 수 있어요','꾸준함은 완벽보다 강해요', '다음', Color(0xFFF0FDFA)),
  fifth('assets/images/onboard/onboard_fifth.png', '가까운 누군가와 가볍게 응원', '500m 안의 사용자와 랜덤 채팅으로\n 오늘의 루틴을 함께 이어가요.','원하면 언제든 종료할 수 있어요', '시작하기', Color(0xFFF0FDF4));

  final String path;
  final String title;
  final String body;
  final String? caption;
  final String buttonText;
  final Color backgroundColor;
  const OnboardContent(this.path, this.title, this.body, this.caption, this.buttonText, this.backgroundColor);

}