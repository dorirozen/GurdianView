import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/in_deployment/video/domain/entity/video_entity.dart';

abstract class VideoRepo {
  VideoRepo();
  ResultFuture<List<Video>> getVideo(String videoId);
}
