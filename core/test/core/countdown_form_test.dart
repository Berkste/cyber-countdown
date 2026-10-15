import 'package:cyber_countdown_core/core/countdown_form.dart';
import 'package:test/test.dart';

void main() {
  final now = DateTime(2026, 10, 14, 12);

  test('an empty or blank title falls back to the default', () {
    expect(CountdownForm.normalizeTitle(''), CountdownForm.defaultTitle);
    expect(CountdownForm.normalizeTitle('   '), CountdownForm.defaultTitle);
  });

  test('a title is trimmed and capped at 40 characters', () {
    expect(CountdownForm.normalizeTitle('  Graduation '), 'Graduation');
    expect(CountdownForm.normalizeTitle('x' * 45), 'x' * 40);
  });

  test('time defaults to midnight', () {
    expect(
      CountdownForm.combine(DateTime(2026, 11, 1, 9, 30)),
      DateTime(2026, 11, 1),
    );
    expect(
      CountdownForm.combine(DateTime(2026, 11, 1), hour: 8, minute: 5),
      DateTime(2026, 11, 1, 8, 5),
    );
  });

  test('a missing, past or current target is rejected', () {
    expect(
      CountdownForm.validateTarget(null, now),
      CountdownForm.missingDateError,
    );
    expect(
      CountdownForm.validateTarget(DateTime(2026, 10, 14), now),
      CountdownForm.pastTargetError,
    );
    expect(
      CountdownForm.validateTarget(now, now),
      CountdownForm.pastTargetError,
    );
    expect(CountdownForm.validateTarget(DateTime(2026, 10, 15), now), isNull);
  });
}
