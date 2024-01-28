import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/*
class VideoDemo extends StatefulWidget {
  VideoDemo() : super();

  final String title = "Video Demo";

  @override
  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<VideoDemo> {
  late VideoPlayerController controller;
/*

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/video.mp4")
      ..addListener(() => setState(() {}))
      ..initialize().then((_) {
        setState(() {
          controller.play();
        });
      });
  }
 */
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/video.mp4")
      ..initialize().then((_) {
        setState(() {
          controller.play();
        });
      });

    controller
        .addListener(videoPlayerListener); // Use a named listener function
  }

  void videoPlayerListener() {
    if (controller.value.hasError) {
      // Handle video error state
      print("Video player error: ${controller.value.errorDescription}");
    }

    if (controller.value.isBuffering) {
      // Optionally handle buffering state
    }

    // Add any other specific checks you need here

    // Update the state if necessary
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(videoPlayerListener);
    controller.dispose();
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) => controller != null &&
          controller.value.isInitialized
      ? Container(
          alignment: Alignment.topCenter,
          child: Stack(children: <Widget>[
            AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller)),
            Positioned.fill(child: BasicOverLayWidget(controller: controller)),
          ]),
        )
      : Container(
          alignment: Alignment.topCenter,
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
}

class BasicOverLayWidget extends StatelessWidget {
  const BasicOverLayWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Stack(
        children: [
          controller.value.isPlaying
              ? Container()
              : Container(
                  alignment: Alignment.center,
                  color: Colors.black26,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(controller,
                allowScrubbing: true, padding: EdgeInsets.all(10.0)),
          ),
        ],
      ),
    );
  }
}
*/
///finished feature !!
/// just for showing video.
/// VideoDemo its the start setting we need to apply for showing a video.
/*
class VideoDemo extends StatefulWidget {
  VideoDemo() : super();

  final String title = "Video Demo";

  @override
  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<VideoDemo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/video.mp4")
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: controller);
  }

  @override
  void dispose() {
    controller.removeListener(() => setState(() {}));
    controller.dispose();
    super.dispose();
  }
}

 */
/// here we use the functionally of the video class
class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController? controller;

  const VideoPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) => controller != null &&
          controller!.value.isInitialized
      ? Container(
          alignment: Alignment.topCenter,
          child: Stack(children: <Widget>[
            AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: VideoPlayer(controller!)),
            Positioned.fill(child: BasicOverLayWidget(controller: controller!)),
          ]),
        )
      : Container(
          alignment: Alignment.topCenter,
          height: 200,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
}

class BasicOverLayWidget extends StatelessWidget {
  const BasicOverLayWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Stack(
        children: [
          controller.value.isPlaying
              ? Container()
              : Container(
                  alignment: Alignment.center,
                  color: Colors.black26,
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(controller,
                allowScrubbing: true, padding: const EdgeInsets.all(10.0)),
          ),
        ],
      ),
    );
  }
}
