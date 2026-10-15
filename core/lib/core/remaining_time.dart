/// How much time is left until a target, split into the units the timer
/// displays.
///
/// Pure Dart: no Flutter imports.
class RemainingTime {
  const RemainingTime._(this.total);

  /// The time left from [now] until [target]. A target in the past counts
  /// as zero, never as a negative duration.
  factory RemainingTime.between(DateTime target, DateTime now) {
    final diff = target.difference(now);
    return RemainingTime._(diff.isNegative ? Duration.zero : diff);
  }

  /// The whole remaining duration, never negative.
  final Duration total;

  bool get isComplete => total == Duration.zero;

  int get days => total.inDays;
  int get hours => total.inHours % Duration.hoursPerDay;
  int get minutes => total.inMinutes % Duration.minutesPerHour;
  int get seconds => total.inSeconds % Duration.secondsPerMinute;

  @override
  bool operator ==(Object other) =>
      other is RemainingTime && other.total == total;

  @override
  int get hashCode => total.hashCode;

  @override
  String toString() =>
      'RemainingTime(${days}d ${hours}h ${minutes}m ${seconds}s)';
}
