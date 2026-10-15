import 'package:cyber_countdown_core/core/remaining_time.dart';
import 'package:test/test.dart';

void main() {
  final now = DateTime.utc(2026, 10, 14, 12);

  group('RemainingTime.between', () {
    test('splits the time left into days, hours, minutes and seconds', () {
      final target = now.add(
        const Duration(days: 3, hours: 4, minutes: 5, seconds: 6),
      );

      final remaining = RemainingTime.between(target, now);

      expect(remaining.days, 3);
      expect(remaining.hours, 4);
      expect(remaining.minutes, 5);
      expect(remaining.seconds, 6);
      expect(remaining.isComplete, isFalse);
    });

    test('a target in the past is complete and counts as zero', () {
      final remaining = RemainingTime.between(
        now.subtract(const Duration(days: 2)),
        now,
      );

      expect(remaining.isComplete, isTrue);
      expect(remaining.total, Duration.zero);
      expect(remaining.days, 0);
      expect(remaining.seconds, 0);
    });

    test('a target at exactly now is complete', () {
      expect(RemainingTime.between(now, now).isComplete, isTrue);
    });

    test('one second before the target is not complete yet', () {
      final remaining = RemainingTime.between(
        now.add(const Duration(seconds: 1)),
        now,
      );

      expect(remaining.isComplete, isFalse);
      expect(remaining.seconds, 1);
    });

    test('rolls hours over into days at the day boundary', () {
      final remaining = RemainingTime.between(
        now.add(const Duration(hours: 24)),
        now,
      );

      expect(remaining.days, 1);
      expect(remaining.hours, 0);
    });

    test('keeps counting days past a year', () {
      final remaining = RemainingTime.between(
        now.add(const Duration(days: 400)),
        now,
      );

      expect(remaining.days, 400);
    });

    test('ignores sub-second leftovers in the displayed units', () {
      final remaining = RemainingTime.between(
        now.add(const Duration(seconds: 59, milliseconds: 999)),
        now,
      );

      expect(remaining.minutes, 0);
      expect(remaining.seconds, 59);
    });

    test('values with the same total are equal', () {
      final target = now.add(const Duration(hours: 1));

      expect(
        RemainingTime.between(target, now),
        RemainingTime.between(
          target.add(const Duration(hours: 1)),
          now.add(const Duration(hours: 1)),
        ),
      );
    });
  });
}
