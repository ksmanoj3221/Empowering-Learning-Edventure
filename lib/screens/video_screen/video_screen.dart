import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:EmpoweringLearningEdventure/constants.dart';

class VideoScreen extends StatefulWidget {
  static const String routeName = 'VideoScreen';

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;

  @override
  void initState() {
    super.initState();

    _controller1 = VideoPlayerController.asset(
      'assets/videos/video1.mp4',
    )..initialize().then((_) {
      setState(() {});
    });

    _controller2 = VideoPlayerController.asset(
      'assets/videos/video2.mp4',
    )..initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
      ),
      body: Column(
        children: [
          _buildVideoPlayer(_controller1),
          _buildVideoPlayer(_controller2),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(VideoPlayerController controller) {
    if (controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(controller),
            _buildPlayPauseOverlay(controller),
          ],
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _buildPlayPauseOverlay(VideoPlayerController controller) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (controller.value.isPlaying) {
            controller.pause();
          } else {
            controller.play();
          }
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Icon(
            controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            size: 50.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}

