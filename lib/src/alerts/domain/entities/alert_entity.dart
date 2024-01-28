import 'package:equatable/equatable.dart';

/// this feature will need to get list of alerts. and so upload an alert.(from another phone).

class Alert extends Equatable {
  final String id;
  final DateTime timestamp;
  final String level;

  ///location
  final double? latitude;
  final double? longitude;
  ///location

  final bool isConfirmed;
  final String description;
  final String videoUrl; // Assuming URLs for video and images
  final List<String>? imageUrls;
  Alert({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.description,
    required this.videoUrl,
    required this.isConfirmed,
    this.longitude,
    this.latitude,
    this.imageUrls,
  });

  @override
  List<Object?> get props => [id, timestamp, level, isConfirmed];

  @override
  String toString() {
    return 'Alert{id: $id, timestamp: $timestamp, level: $level, latitude: $latitude, longitude: $longitude, isConfirmed: $isConfirmed, description: $description, videoUrl: $videoUrl, imageUrls: $imageUrls}';
  }

  Alert.empty()
      : this(
            id: '',
            description: '',
            timestamp: DateTime.now(),
            videoUrl: '',
            level: '',
            isConfirmed: false);
}

/*

class U {
  const U({required this.id, required this.name, required this.city});
  final String name;
  final String id;
  final String city;
  static U fromJson(json) => U(
        name: json['name'],
        id: json['id'],
        city: json['city'],
      );
}
 */
