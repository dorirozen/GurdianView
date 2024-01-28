import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';

abstract class VideoState extends Equatable {
  const VideoState();
  @override
  List<Object?> get props => [];
}

///basics
class VideoStateInitial extends VideoState {
  const VideoStateInitial();
}

class VideoStateLoading extends VideoState {
  const VideoStateLoading();
}

class VideoStateError extends VideoState {
  const VideoStateError({required this.message});
  final String message;
}

class VideoStateAdding extends VideoState {
  const VideoStateAdding(this.progress);
  final double progress;
  @override
  List<Object?> get props => [progress];
}

class VideoStateAdded extends VideoState {
  final TaskSnapshot taskSnapshot;
  final VideoData videoData;
  const VideoStateAdded({required this.taskSnapshot, required this.videoData});
}
