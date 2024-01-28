import 'package:equatable/equatable.dart';

class VideoData extends Equatable {
  final String uid;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  final String videoUrl;
  VideoData(
      {required this.uid,
      required this.latitude,
      required this.longitude,
      required this.timestamp,
      this.videoUrl = ''});

  @override
  List<Object?> get props => [uid, latitude, longitude, timestamp];

  @override
  String toString() {
    return 'VideoData{uid: $uid, latitude: $latitude, longitude: $longitude, timestamp: $timestamp, videoUrl: $videoUrl}';
  }

  VideoData.empty()
      : this(
            uid: '',
            videoUrl: '',
            timestamp: DateTime.now(),
            latitude: 0.0,
            longitude: 0.0);
}
