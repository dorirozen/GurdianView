import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:guardian_view/core/common/usecases/usecase.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/video/domain/entity/file_entity.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';
import 'package:guardian_view/src/video/domain/repo_video/repo_video.dart';

class AddVideoDataUS
    implements UsecaseWithParams<Stream<TaskSnapshot>, VideoParams> {
  const AddVideoDataUS(this._videoRepo);
  final VideoRepo _videoRepo;

  @override
  ResultFuture<Stream<TaskSnapshot>> call(VideoParams params) => _videoRepo
      .addVideoData(videoFile: params.videoFile, videoData: params.videoData);
}

class VideoParams extends Equatable {
  final VideoData videoData;
  final VideoFile videoFile;
  VideoParams(this.videoData, this.videoFile);

  @override
  List<Object?> get props => [videoData, videoFile];
}
