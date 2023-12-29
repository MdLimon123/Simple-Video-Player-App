import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class VideoPlayScreen extends StatefulWidget {
  VideoPlayScreen({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.viewers,
  });
  String videoUrl;
  String title;
  String viewers;

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isOverlayVisible = false;

  @override
  void initState() {
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((value) {
            setState(() {
              _videoController.setLooping(true);
              _videoController.play();
            });
          });
    _initializeVideoPlayerFuture = _videoController.initialize();

    _videoController.addListener(() {
      if (!_videoController.value.isPlaying) {
        setState(() {
          _isOverlayVisible = true;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          } else {
                            _videoController.play();
                          }
                          _isOverlayVisible = !_isOverlayVisible;
                        });
                      },
                      child: Stack(children: [
                        AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        ),
                        Positioned(
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ))),
                        Center(
                          child: AnimatedOpacity(
                            opacity: _isOverlayVisible ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Center(
                              child: Icon(
                                _videoController.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A202C)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${widget.viewers.toString()} views",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF72777B)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
