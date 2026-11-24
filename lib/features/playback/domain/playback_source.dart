/// A short-lived media source; never use its URL as a library primary key.
final class PlaybackSource {
  PlaybackSource({
    required this.trackId,
    required this.uri,
    Map<String, String> headers = const {},
    this.expiresAt,
  }) : headers = Map.unmodifiable(headers);

  final String trackId;
  final Uri uri;
  final Map<String, String> headers;
  final DateTime? expiresAt;
}
