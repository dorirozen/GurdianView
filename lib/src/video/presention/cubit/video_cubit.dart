import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/src/video/domain/entity/file_entity.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';
import 'package:guardian_view/src/video/domain/usecases/add_video_us.dart';
import 'package:guardian_view/src/video/presention/cubit/video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit({required AddVideoDataUS addVideoDataUS})
      : _addVideoDataUS = addVideoDataUS,
        super(const VideoStateInitial()) {
    emit(const VideoStateLoading());
  }
  final AddVideoDataUS _addVideoDataUS;
  StreamSubscription? _uploadTaskSubscription;
  bool _isStreamInitialized = false;
  Future<void> addVideoDataUs(VideoData videoData, VideoFile videoFile) async {
    final res = await _addVideoDataUS(VideoParams(videoData, videoFile));

    res.fold((failure) {
      debugPrint("cubit VideoStateError");
      emit(VideoStateError(message: failure.errorMessage));
    }, (uploadTask) {
      debugPrint("i am here (uploadTask) ");
      _uploadTaskSubscription?.cancel();
      _isStreamInitialized = true;
      _uploadTaskSubscription = uploadTask.listen(
        (taskSnapshot) {
          debugPrint("i am here (taskSnapshot)");
          switch (taskSnapshot.state) {
            case TaskState.running:
              // You can emit a state with the progress here
              final progress = 100 *
                  (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
              emit(VideoStateAdding(progress));
              break;
            case TaskState.success:
              emit(VideoStateAdded(
                  taskSnapshot: taskSnapshot, videoData: videoData));
              break;
            case TaskState.error:
              debugPrint("TaskState.error");
              emit(const VideoStateError(message: "Upload failed"));
              break;
            default:
              break;
          }
        },
        onError: (error) {
          debugPrint("cubit onError");
          _isStreamInitialized = true;
          emit(VideoStateError(message: error.toString())); // Emit error state
          close();
        },
      );
    });
  }

  // Method to check if the stream is initialized
  bool checkStreamInitialized() {
    debugPrint('stream checked if initilized from cubit');
    return _isStreamInitialized;
  }

  @override
  Future<void> close() {
    debugPrint('video disposed from cubit');
    _uploadTaskSubscription?.cancel();
    _isStreamInitialized = false;
    return super.close();
  }
}
