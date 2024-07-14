import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:video_player/video_player.dart';

import '../../../../controllers/libarary_video_media_controller.dart';
import '../../../../models/libarary_video_media_model.dart';

class NewsVideoScreen extends StatefulWidget {
  late int id;
  NewsVideoScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _NewsVideoScreenState createState() => _NewsVideoScreenState();
}

class _NewsVideoScreenState extends State<NewsVideoScreen> {
  final libararyMediaController = Get.put(LibararyVideoMediaController());

  @override
  void initState() {
    libararyMediaController.getCemetery(widget.id, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Obx(
          () {
            return libararyMediaController.isLoding.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.background,
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: AppColors.background,
                    color: AppColors.text,
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () async {
                          await libararyMediaController.getCemetery(
                              widget.id, 1);
                        },
                      );
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount:
                          libararyMediaController.libarary_media_video.length,
                      itemBuilder: (context, index) {
                        return buildVideoServices(
                            libararyMediaController.libarary_media_video[index],
                            context);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildVideoServices(
      LibararyVideoMediaModel video, BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.background.withOpacity(0.1),
                    AppColors.text
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videocam,
                    color: AppColors.background,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "ملف فيديو",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.shadow,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenVideoPlayer(
                  url:
                      "https://cemetery2.bmwit.com/public/News-details/${video.media}",
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class FullScreenVideoPlayer extends StatefulWidget {
  final String url;

  const FullScreenVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
      _isPlaying = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('تشغيل الفيديو'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.amber,
                  ),
                ),
                _buildPlayPauseButton(),
              ],
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.text,
              backgroundColor: AppColors.background,
            ));
          }
        },
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
            _isPlaying = false;
          } else {
            _controller.play();
            _isPlaying = true;
          }
        });
      },
      child: Container(
        color: AppColors.shadow,
        child: Center(
          child: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            color: AppColors.text,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
