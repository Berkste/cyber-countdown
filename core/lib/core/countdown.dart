/// A single countdown the user has set up: what is being counted down to,
/// and when it happens.
///
/// Pure Dart on purpose: no Flutter imports, so the model and its tests run
/// on the plain Dart VM.
class Countdown {
  const Countdown({
    required this.title,
    required this.target,
    required this.createdAt,
    this.themeId = defaultThemeId,
  });

  /// The theme every countdown starts with until the user picks another.
  static const String defaultThemeId = 'cyber';

  /// Short label shown above the timer, e.g. "Military service ends".
  final String title;

  /// The moment the countdown reaches zero, in the device's local time.
  final DateTime target;

  /// When the user created this countdown.
  final DateTime createdAt;

  /// Which visual theme renders this countdown.
  final String themeId;

  Countdown copyWith({
    String? title,
    DateTime? target,
    DateTime? createdAt,
    String? themeId,
  }) {
    return Countdown(
      title: title ?? this.title,
      target: target ?? this.target,
      createdAt: createdAt ?? this.createdAt,
      themeId: themeId ?? this.themeId,
    );
  }

  Map<String, Object?> toJson() => {
    'title': title,
    'target': target.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'themeId': themeId,
  };

  /// Throws a [FormatException] if [json] is missing a field or holds a
  /// value of the wrong type.
  factory Countdown.fromJson(Map<String, Object?> json) {
    final title = json['title'];
    final target = json['target'];
    final createdAt = json['createdAt'];
    final themeId = json['themeId'] ?? defaultThemeId;

    if (title is! String || target is! String || createdAt is! String) {
      throw FormatException('Countdown JSON is missing a field', json);
    }
    if (themeId is! String) {
      throw FormatException('Countdown themeId must be a string', json);
    }

    return Countdown(
      title: title,
      target: DateTime.parse(target),
      createdAt: DateTime.parse(createdAt),
      themeId: themeId,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Countdown &&
      other.title == title &&
      other.target == target &&
      other.createdAt == createdAt &&
      other.themeId == themeId;

  @override
  int get hashCode => Object.hash(title, target, createdAt, themeId);

  @override
  String toString() => 'Countdown($title, $target, theme: $themeId)';
}
