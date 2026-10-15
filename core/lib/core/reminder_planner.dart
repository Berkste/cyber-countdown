import 'countdown.dart';

/// One notification to show at [at].
class Reminder {
  const Reminder({
    required this.id,
    required this.at,
    required this.title,
    required this.body,
  });

  /// Stable per moment, so rescheduling replaces rather than duplicates.
  final int id;
  final DateTime at;
  final String title;
  final String body;

  @override
  bool operator ==(Object other) =>
      other is Reminder &&
      other.id == id &&
      other.at == at &&
      other.title == title &&
      other.body == body;

  @override
  int get hashCode => Object.hash(id, at, title, body);

  @override
  String toString() => 'Reminder($id, $at, $body)';
}

/// Decides which reminders a countdown gets: 7 days, 1 day and 1 hour
/// before the target, and at the target itself.
///
/// Pure Dart, so the schedule is tested without a device.
abstract final class ReminderPlanner {
  static const List<(Duration, String)> _moments = [
    (Duration(days: 7), '7 days to go'),
    (Duration(days: 1), '1 day to go'),
    (Duration(hours: 1), '1 hour to go'),
    (Duration.zero, 'Target reached!'),
  ];

  /// The reminders still ahead of [now], earliest first. Moments that have
  /// already passed are skipped.
  static List<Reminder> plan(Countdown countdown, DateTime now) {
    return [
      for (final (index, (before, body)) in _moments.indexed)
        if (countdown.target.subtract(before).isAfter(now))
          Reminder(
            id: index,
            at: countdown.target.subtract(before),
            title: countdown.title,
            body: body,
          ),
    ];
  }

  /// Every id [plan] can produce, for cancelling.
  static Iterable<int> get allIds => Iterable.generate(_moments.length);
}
