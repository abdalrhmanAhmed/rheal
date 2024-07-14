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
    libararyMediaController.getNewsVideoMedia(widget.id, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Obx(
          () {
            if (libararyMediaController.isLoding.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.background,
                ),
              );
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: libararyMediaController.libarary_media_video.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenVideoPlayer(
                            url:
                                "https://cemetery2.bmwit.com/public/News-details/${libararyMediaController.libarary_media_video[index].media}",
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      'https://app.enjazarea.com/uploads/settings/1/WhatsApp-Image-2024-03-19-at-9.06.48-PM.jpeg',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
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
        color: Colors.black26,
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
