import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:guardian_view/core/error/exceptions.dart';
import 'package:guardian_view/core/error/failures.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/video/data/data_sources/remote_data_source.dart';
import 'package:guardian_view/src/video/domain/entity/file_entity.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';
import 'package:guardian_view/src/video/domain/repo_video/repo_video.dart';

class RepoVideoImpl implements VideoRepo {
  final DataSourceVideo _dataSourceVideo;
  RepoVideoImpl(this._dataSourceVideo);
  @override
  ResultFuture<Stream<TaskSnapshot>> addVideoData(
      {required VideoFile videoFile, required VideoData videoData}) async {
    try {
      final res = await _dataSourceVideo.addVideoData(
          videoData: videoData, videoFile: videoFile);
      return Right(res);
      //return const Right(null);
    } on ServerException catch (e) {
      debugPrint("RepoVideoImpl");
      throw Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> postUploadData(
      {required VideoData videoData,
      required TaskSnapshot taskSnapshot}) async {
    try {
      await _dataSourceVideo.postUploadTask(
          videoData: videoData, taskSnapshot: taskSnapshot);
      return const Right(null);
      //return const Right(null);
    } on ServerException catch (e) {
      debugPrint("RepoVideoImpl");
      throw Left(ServerFailure.fromException(e));
    }
  }
}
