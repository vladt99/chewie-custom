import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:video_player/video_player.dart';

class BTKCustomVideoPlayer extends StatelessWidget {
  const BTKCustomVideoPlayer({
    super.key,
    required this.webIdentifier,
    required this.source,
    this.useIosVersion = false,
    this.isTitleVisible,
    this.title,
  });

  final String webIdentifier;
  final String source;
  final bool? isTitleVisible;
  final String? title;
  final bool useIosVersion;

  bool get _isIOSBrowser {
    if (useIosVersion) {
      return true;
    }

    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('iphone') ||
        userAgent.contains('ipad') ||
        userAgent.contains('applewebkit');
  }

  Future<void> _showVideoModal(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: SizedBox(
            width: 600,
            height: 400,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                _DefaultBTKCustomVideoPlayer(
                  webIdentifier: webIdentifier,
                  source: source,
                  isTitleVisible: isTitleVisible,
                  title: title,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isIOSBrowser
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _showVideoModal(context),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFCE002F),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Tap to play video',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ))
        : _DefaultBTKCustomVideoPlayer(
            webIdentifier: webIdentifier,
            source: source,
            isTitleVisible: isTitleVisible,
            title: title,
          );
  }
}

class _DefaultBTKCustomVideoPlayer extends StatefulWidget {
  const _DefaultBTKCustomVideoPlayer({
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
  State<_DefaultBTKCustomVideoPlayer> createState() =>
      _DefaultBTKCustomVideoPlayerState();
}

class _DefaultBTKCustomVideoPlayerState
    extends State<_DefaultBTKCustomVideoPlayer> {
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
  Future<void> dispose() async {
    await _videoPlayerController1.dispose();
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
