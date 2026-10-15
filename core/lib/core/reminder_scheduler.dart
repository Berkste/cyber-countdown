import 'reminder_planner.dart';

/// Shows [Reminder]s as system notifications.
abstract interface class ReminderScheduler {
  /// Asks the user for notification permission where the platform needs it.
  /// Returns whether notifications may be shown.
  Future<bool> requestPermission();

  /// Replaces every scheduled reminder with [reminders].
  Future<void> schedule(List<Reminder> reminders);

  Future<void> cancelAll();
}

/// Schedules nothing; used until a platform scheduler is plugged in.
class NoopReminderScheduler implements ReminderScheduler {
  const NoopReminderScheduler();

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> schedule(List<Reminder> reminders) async {}

  @override
  Future<void> cancelAll() async {}
}
