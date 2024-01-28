import 'package:equatable/equatable.dart';

abstract class PostUploadState extends Equatable {
  const PostUploadState();
  @override
  List<Object?> get props => [];
}

class PostUploadInitial extends PostUploadState {
  const PostUploadInitial();
}
