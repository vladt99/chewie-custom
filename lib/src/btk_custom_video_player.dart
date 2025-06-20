import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:universal_html/html.dart' as html;
import 'package:video_player/video_player.dart';

class BTKCustomVideoPlayer extends StatelessWidget {
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

  bool get _isIOSBrowser {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('iphone') || userAgent.contains('ipad');
  }

  @override
  Widget build(BuildContext context) {
    return _isIOSBrowser
        ? _OptimizedBTKCustomVideoPlayer(
            webIdentifier: webIdentifier,
            source: source,
            isTitleVisible: isTitleVisible,
            title: title,
          )
        : _StockBTKCustomVideoPlayer(
            webIdentifier: webIdentifier,
            source: source,
            isTitleVisible: isTitleVisible,
            title: title,
          );
  }
}

class _OptimizedBTKCustomVideoPlayer extends StatefulWidget {
  const _OptimizedBTKCustomVideoPlayer({
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
  State<_OptimizedBTKCustomVideoPlayer> createState() =>
      __OptimizedBTKCustomVideoPlayerState();
}

class __OptimizedBTKCustomVideoPlayerState
    extends State<_OptimizedBTKCustomVideoPlayer> {
  late final _player = Player();
  late final _controller = VideoController(_player);

  @override
  void initState() {
    _player.open(Media(
      widget.source,
    ));

    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
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
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Video(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
        ),
      ],
    );
  }
}

class _StockBTKCustomVideoPlayer extends StatefulWidget {
  const _StockBTKCustomVideoPlayer({
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
  State<_StockBTKCustomVideoPlayer> createState() =>
      _StockBTKCustomVideoPlayerState();
}

class _StockBTKCustomVideoPlayerState
    extends State<_StockBTKCustomVideoPlayer> {
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
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withValues(alpha: 0.8),
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
