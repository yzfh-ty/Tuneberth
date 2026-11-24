import 'playback_source.dart';

enum PlaybackStatus { idle, loading, playing, paused, completed, error }

final class PlaybackState {
  const PlaybackState({
    required this.status,
    this.trackId,
    this.position = Duration.zero,
    this.duration,
    this.errorMessage,
  });

  final PlaybackStatus status;
  final String? trackId;
  final Duration position;
  final Duration? duration;
  final String? errorMessage;
}

/// Implemented separately by Android and desktop playback adapters.
abstract interface class PlaybackEngine {
  Stream<PlaybackState> get states;
  Future<void> load(PlaybackSource source, {Duration position = Duration.zero});
  Future<void> play();
  Future<void> pause();
  Future<void> seek(Duration position);
  Future<void> stop();
  Future<void> dispose();
}
