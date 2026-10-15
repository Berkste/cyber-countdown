import 'countdown.dart';

/// Where the user's countdown is kept between launches.
///
/// The app holds a single countdown; saving replaces whatever was there.
abstract interface class CountdownRepository {
  /// The saved countdown, or `null` if none is saved or the stored data
  /// can no longer be read.
  Future<Countdown?> load();

  Future<void> save(Countdown countdown);

  Future<void> clear();
}
