import 'package:cyber_countdown_core/core/countdown.dart';
import 'package:test/test.dart';

void main() {
  final countdown = Countdown(
    title: 'Military service ends',
    target: DateTime(2027, 3, 1, 9, 30),
    createdAt: DateTime(2026, 10, 14, 12),
    themeId: 'journey',
  );

  group('Countdown JSON', () {
    test('survives a round trip', () {
      expect(Countdown.fromJson(countdown.toJson()), countdown);
    });

    test('falls back to the default theme when themeId is missing', () {
      final json = countdown.toJson()..remove('themeId');

      expect(Countdown.fromJson(json).themeId, Countdown.defaultThemeId);
    });

    test('rejects a missing title', () {
      final json = countdown.toJson()..remove('title');

      expect(() => Countdown.fromJson(json), throwsFormatException);
    });

    test('rejects a target that is not a string', () {
      final json = countdown.toJson()..['target'] = 12345;

      expect(() => Countdown.fromJson(json), throwsFormatException);
    });

    test('rejects a target that is not a date', () {
      final json = countdown.toJson()..['target'] = 'next tuesday';

      expect(() => Countdown.fromJson(json), throwsFormatException);
    });

    test('rejects a themeId that is not a string', () {
      final json = countdown.toJson()..['themeId'] = 7;

      expect(() => Countdown.fromJson(json), throwsFormatException);
    });
  });

  group('Countdown value semantics', () {
    test('copyWith changes only the given fields', () {
      final changed = countdown.copyWith(title: 'Graduation');

      expect(changed.title, 'Graduation');
      expect(changed.target, countdown.target);
      expect(changed.createdAt, countdown.createdAt);
      expect(changed.themeId, countdown.themeId);
    });

    test('equal fields mean equal countdowns and hash codes', () {
      final copy = countdown.copyWith();

      expect(copy, countdown);
      expect(copy.hashCode, countdown.hashCode);
    });

    test('new countdowns use the cyber theme by default', () {
      final plain = Countdown(
        title: 'x',
        target: DateTime(2027),
        createdAt: DateTime(2026),
      );

      expect(plain.themeId, 'cyber');
    });
  });
}
