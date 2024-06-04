import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/models/libarary_media_model.dart';
import 'package:video_player/video_player.dart';

import '../../../controllers/libarary_media_controller.dart';
import '../../../controllers/libarary_video_media_controller.dart';
import '../../../models/libarary_video_media_model.dart';

class LibararyVideoScreen extends StatefulWidget {
  late int id;
  LibararyVideoScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _LibararyVideoScreenState createState() => _LibararyVideoScreenState();
}

class _LibararyVideoScreenState extends State<LibararyVideoScreen> {
  final libararyMediaController = Get.put(LibararyVideoMediaController());

  @override
  void initState() {
    libararyMediaController.getLibararyVideoMedia(widget.id, 'video');
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
                  color: Color(0xFF54D3C2),
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
                      _showVideoDialog(
                          libararyMediaController.libarary_media_video[index]);
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

  void _showVideoDialog(LibararyVideoMediaModel video) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 350,
          child: CustomVideoPlayer(
              url:
                  "https://cemetery2.bmwit.com/public/libary-details/${video.media}"),
        ),
      ),
    );
  }
}

class CustomVideoPlayer extends StatefulWidget {
  final String url;

  const CustomVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
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
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Colors.amber,
                  // handleColor: Colors.amberAccent,
                ),
              ),
              _buildPlayPauseButton(),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
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
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
