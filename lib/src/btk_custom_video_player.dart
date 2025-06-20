import 'package:btk_toolkit/btk_toolkit.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BTKCustomVideoPlayer extends StatefulWidget {
  const BTKCustomVideoPlayer({
    super.key,
    required this.webIdentifier,
    required this.source,
    this.isTitleVisible,
    this.title,
  });

  final String webIdentifier;
  final String source;
  final bool? isTitleVisible;
  final String? title;

  @override
  State<BTKCustomVideoPlayer> createState() => _BTKCustomVideoPlayerState();
}

class _BTKCustomVideoPlayerState extends State<BTKCustomVideoPlayer> {
  late final VideoPlayerController _videoPlayerController1;
  late final ChewieController _chewieController;

  @override
  void initState() {
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(widget.source));
    _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,
      aspectRatio: 16 / 9,
      hideControlsTimer: const Duration(seconds: 1),
    );

    _chewieController.addListener(() {
      if (_chewieController.isFullScreen == false) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isTitleVisible != null &&
            widget.isTitleVisible! &&
            widget.title != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title!,
                style: HSTextStyles.textStyle(
                  context,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: HSColors.primaryBlack.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(
            webIdentifier: widget.webIdentifier,
            controller: _chewieController,
          ),
        ),
      ],
    );
  }
}
