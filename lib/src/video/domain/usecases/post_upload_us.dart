import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:guardian_view/core/common/usecases/usecase.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';
import 'package:guardian_view/src/video/domain/repo_video/repo_video.dart';

class PostUploadUS implements UsecaseWithParams<void, PostUploadData> {
  const PostUploadUS(this._videoRepo);
  final VideoRepo _videoRepo;

  @override
  ResultFuture<void> call(PostUploadData params) => _videoRepo.postUploadData(
      videoData: params.videoData, taskSnapshot: params.taskSnapshot);
}

class PostUploadData extends Equatable {
  final VideoData videoData;
  final TaskSnapshot taskSnapshot;
  PostUploadData({required this.videoData, required this.taskSnapshot});

  @override
  List<Object?> get props => [videoData, taskSnapshot];
}
