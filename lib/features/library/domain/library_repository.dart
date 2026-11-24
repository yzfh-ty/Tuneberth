import 'music_track.dart';

/// Aggregates cloud and local music independently of the UI and player backend.
abstract interface class LibraryRepository {
  Future<List<MusicTrack>> loadTracks();
  Future<List<MusicTrack>> search(String query);
}
