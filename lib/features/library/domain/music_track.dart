enum MusicSourceType { cloud115, local }

/// Stable library identity is independent of expiring playback URLs.
final class MusicTrack {
  const MusicTrack({
    required this.id,
    required this.sourceId,
    required this.sourceType,
    required this.title,
    this.artist = '',
    this.album = '',
    this.duration,
    this.artwork,
  });

  final String id;
  final String sourceId;
  final MusicSourceType sourceType;
  final String title;
  final String artist;
  final String album;
  final Duration? duration;
  final Uri? artwork;
}
