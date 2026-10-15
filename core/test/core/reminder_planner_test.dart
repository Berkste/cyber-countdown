import 'package:cyber_countdown_core/core/countdown.dart';
import 'package:cyber_countdown_core/core/reminder_planner.dart';
import 'package:test/test.dart';

void main() {
  final now = DateTime(2026, 10, 14, 12);

  Countdown countdownAt(DateTime target) =>
      Countdown(title: 'Trip', target: target, createdAt: now);

  test('a far-off target gets all four reminders, earliest first', () {
    final target = DateTime(2026, 12, 1, 9);
    final reminders = ReminderPlanner.plan(countdownAt(target), now);

    expect(reminders.map((r) => r.at), [
      DateTime(2026, 11, 24, 9),
      DateTime(2026, 11, 30, 9),
      DateTime(2026, 12, 1, 8),
      target,
    ]);
    expect(reminders.map((r) => r.id), [0, 1, 2, 3]);
  });

  test('reminders carry the title and a message per moment', () {
    final reminders = ReminderPlanner.plan(
      countdownAt(DateTime(2026, 12, 1)),
      now,
    );

    expect(reminders.every((r) => r.title == 'Trip'), isTrue);
    expect(reminders.map((r) => r.body), [
      '7 days to go',
      '1 day to go',
      '1 hour to go',
      'Target reached!',
    ]);
  });

  test('moments already passed are skipped', () {
    final reminders = ReminderPlanner.plan(
      countdownAt(now.add(const Duration(days: 3))),
      now,
    );

    expect(reminders.map((r) => r.id), [1, 2, 3]);
  });

  test('a moment exactly now is skipped', () {
    final reminders = ReminderPlanner.plan(
      countdownAt(now.add(const Duration(hours: 1))),
      now,
    );

    expect(reminders.map((r) => r.id), [3]);
  });

  test('a reached target gets no reminders', () {
    expect(ReminderPlanner.plan(countdownAt(now), now), isEmpty);
  });
}
