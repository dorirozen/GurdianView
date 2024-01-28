import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/src/video/domain/usecases/post_upload_us.dart';
import 'package:guardian_view/src/video/presention/cubit/post_upload_state.dart';
import 'package:guardian_view/src/video/presention/cubit/video_cubit.dart';
import 'package:guardian_view/src/video/presention/cubit/video_state.dart';

class PostUploadCubit extends Cubit<PostUploadState> {
  final VideoCubit _videoCubit;
  late StreamSubscription videoCubitSubscription;
  final PostUploadUS _postUploadUS;
  PostUploadCubit(
      {required VideoCubit videoCubit, required PostUploadUS postUploadUS})
      : _postUploadUS = postUploadUS,
        _videoCubit = videoCubit,
        super(const PostUploadInitial()) {
    videoCubitSubscription = _videoCubit.stream.listen((videoState) async {
      if (videoState is VideoStateAdded) {
        await _postUploadUS(PostUploadData(
            videoData: videoState.videoData,
            taskSnapshot: videoState.taskSnapshot));
      }
    });
  }

  @override
  Future<void> close() {
    videoCubitSubscription.cancel();
    return super.close();
  }
}
