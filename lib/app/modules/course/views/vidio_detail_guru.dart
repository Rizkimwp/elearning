import 'package:elearning/app/data/videomaterial/controller/vidio_controller.dart';
import 'package:elearning/app/data/videomaterial/vidio.dart';
import 'package:elearning/utils/global_config.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetailScreen extends StatefulWidget {
  final Vidio vidio;

  const VideoDetailScreen({Key? key, required this.vidio}) : super(key: key);

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late VideoPlayerController _controller;
  late Uri file;

  @override
  void initState() {
    super.initState();
    file = Uri.parse(GlobalConfig.baseUrl + (widget.vidio.videoUrl ?? ''));
    _controller = VideoPlayerController.networkUrl(file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPoint(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 251, 251, 251),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    const BackButton(color: Colors.black),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.fullscreen, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
                // Container dengan ukuran yang disesuaikan berdasarkan ukuran layar
                Container(
                  width: screenSize.width,
                  height:
                      screenSize.width /
                      (_controller.value.isInitialized
                          ? _controller.value.aspectRatio
                          : 16 /
                              9), // Menghitung tinggi berdasarkan lebar dan rasio aspek
                  child:
                      _controller.value.isInitialized
                          ? Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(_controller),
                              IconButton(
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause_circle
                                      : Icons.play_circle,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                    playedColor: Colors.orange,
                                    backgroundColor: Colors.white24,
                                  ),
                                ),
                              ),
                            ],
                          )
                          : const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product Design",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.vidio.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildPoint(
                    "1. Knowledge base",
                    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
                  ),
                  _buildPoint(
                    "2. Definition of Design",
                    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
                  ),
                  _buildPoint(
                    "3. Technical Design",
                    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Next", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
