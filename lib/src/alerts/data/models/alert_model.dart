import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/alerts/domain/entities/alert_entity.dart';

class AlertModel extends Alert {
  AlertModel({
    required super.id,
    required super.timestamp,
    required super.level,
    required super.description,
    required super.videoUrl,
    required super.isConfirmed,
    super.longitude,
    super.latitude,
    super.imageUrls,
  });

  DataMap toMap() {
    return {
      'id': id,
      'timestamp': FieldValue.serverTimestamp(),
      'level': level,
      'latitude': latitude,
      'longitude': longitude,
      'isConfirmed': isConfirmed,
      'description': description,
      'videoUrl': videoUrl,
      'imageUrls': imageUrls,
    };
  }

  AlertModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          timestamp: (map['timestamp'] as Timestamp).toDate(),
          level: map['level'] as String,
          latitude: (map['latitude'] as num?)?.toDouble(),
          longitude: (map['longitude'] as num?)?.toDouble(),
          isConfirmed: map['isConfirmed'] as bool,
          description: map['description'] as String,
          videoUrl: map['videoUrl'] as String,
          imageUrls: map['imageUrls'] as List<String>?,
        );
}
