import 'package:equatable/equatable.dart';

class Video extends Equatable {
  const Video({
    required this.id,
    required this.videoURL, // will be File
    required this.uploadTime,
  });
  final String id;
  final String videoURL;
  final DateTime uploadTime;

  Video.empty()
      : this(
          id: 'empty_id',
          videoURL: 'empty_url',
          uploadTime: DateTime.now(),
        );
  @override
  List<Object?> get props => [id];
}
