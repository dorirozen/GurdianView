import 'package:firebase_storage/firebase_storage.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/video/domain/entity/file_entity.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';

abstract class VideoRepo {
  const VideoRepo();
  ResultFuture<Stream<TaskSnapshot>> addVideoData(
      {required VideoFile videoFile, required VideoData videoData});
  ResultFuture<void> postUploadData(
      {required VideoData videoData, required TaskSnapshot taskSnapshot});
}
