enum HealthDtlHeartSummary {
  avg('평균', 'assets/images/icon/heart_avg.svg'),
  high('최고', 'assets/images/icon/heart_max.svg'),
  low('최저', 'assets/images/icon/heart_low.svg');

  final String name;
  final String assetPath;

  const HealthDtlHeartSummary(this.name, this.assetPath);
}