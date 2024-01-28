import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';

class VideoDataModel extends VideoData {
  VideoDataModel(
      {required super.uid,
      required super.latitude,
      required super.longitude,
      required super.timestamp,
      super.videoUrl});

  DataMap toMap() {
    return {
      'uid': uid,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': FieldValue.serverTimestamp(),
      'videoUrl': videoUrl,
    };
  }

  VideoDataModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          latitude: (map['latitude'] as num).toDouble(),
          longitude: (map['longitude'] as num).toDouble(),
          timestamp: (map['timestamp'] as Timestamp).toDate(),
          videoUrl: map['videoUrl'] as String,
        );

  VideoDataModel copyWith(
      {String? videoUrl,
      DateTime? timestamp,
      double? latitude,
      double? longitude,
      String? uid}) {
    return VideoDataModel(
      longitude: longitude ?? this.longitude,
      uid: uid ?? this.uid,
      latitude: latitude ?? this.latitude,
      timestamp: timestamp ?? this.timestamp,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
