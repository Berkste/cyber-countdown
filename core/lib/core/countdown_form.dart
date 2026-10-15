/// Rules for what the user may enter when setting up a countdown.
///
/// Pure Dart, like the rest of `core`, so the rules are tested on the VM.
abstract final class CountdownForm {
  static const int maxTitleLength = 40;

  /// Used when the user leaves the title empty.
  static const String defaultTitle = 'COUNTDOWN';

  static const String missingDateError = 'SELECT A DATE';
  static const String pastTargetError = 'TARGET MUST BE IN THE FUTURE';

  /// Trims [raw]; an empty title becomes [defaultTitle].
  static String normalizeTitle(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return defaultTitle;
    return trimmed.length > maxTitleLength
        ? trimmed.substring(0, maxTitleLength)
        : trimmed;
  }

  /// The [date] at [hour]:[minute]; the time is optional and defaults to
  /// midnight.
  static DateTime combine(DateTime date, {int hour = 0, int minute = 0}) =>
      DateTime(date.year, date.month, date.day, hour, minute);

  /// An error message, or `null` if [target] may be saved at [now].
  static String? validateTarget(DateTime? target, DateTime now) {
    if (target == null) return missingDateError;
    if (!target.isAfter(now)) return pastTargetError;
    return null;
  }
}
