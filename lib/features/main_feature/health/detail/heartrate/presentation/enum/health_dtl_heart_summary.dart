enum HealthDtlHeartSummary {
  avg('평균', 'heart_avg.svg'),
  high('최고', 'heart_avg.svg'),
  low('최저', 'heart_avg.svg');

  final String name;
  final String assetPath;

  const HealthDtlHeartSummary(this.name, this.assetPath);
}