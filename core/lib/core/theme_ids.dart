import 'countdown.dart';

/// The themes a countdown can be rendered with, by the id stored in
/// [Countdown.themeId].
abstract final class ThemeIds {
  static const String cyber = Countdown.defaultThemeId;
  static const String journey = 'journey';
  static const String celebration = 'celebration';

  static const List<String> all = [cyber, journey, celebration];

  /// The name shown in theme pickers.
  static String label(String id) => switch (id) {
    journey => 'JOURNEY',
    celebration => 'CELEBRATION',
    _ => 'CYBER',
  };
}
