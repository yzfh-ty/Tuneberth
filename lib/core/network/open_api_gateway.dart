import '../../features/library/domain/music_track.dart';
import '../../features/playback/domain/playback_source.dart';

/// Cloud access boundary. An official OpenAPI implementation will be injected.
///
/// No Cookie client, embedded application secret, or assumed API endpoint is
/// part of the scaffold. Pagination is normalized by the implementation.
abstract interface class OpenApiGateway {
  Future<List<MusicTrack>> listTracks(String directoryId);
  Future<MusicTrack> getTrack(String trackId);
  Future<PlaybackSource> resolvePlayback(String trackId);
}
