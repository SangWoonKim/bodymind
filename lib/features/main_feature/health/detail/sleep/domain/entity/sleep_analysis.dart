class SleepAnalysis {
  final String sleepTimeAnalysis;
  final String sleepRatioAnalysis;
  final String sleepCareAnalysis;

  SleepAnalysis(
      this.sleepTimeAnalysis,
      this.sleepRatioAnalysis,
      this.sleepCareAnalysis);

   SleepAnalysis copyWith({
      String? sleepTimeAnalysis,
      String? sleepRatioAnalysis,
      String? sleepCareAnalysis
   }){
    return SleepAnalysis(
        sleepTimeAnalysis ?? this.sleepTimeAnalysis,
        sleepRatioAnalysis ?? this.sleepRatioAnalysis,
        sleepCareAnalysis ?? this.sleepRatioAnalysis);
  }

  factory SleepAnalysis.invalid(String reason) {
    return SleepAnalysis(
      '수면 데이터를 충분히 확인하지 못했어요',
      '기록이 일부 부족해 정확한 해석이 어려워요',
      '수면 기록을 더 확인해볼게요',
    );
  }
}