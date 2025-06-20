import 'dart:ui_web' as ui;

import 'package:chewie/src/helpers/html_video_setup.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

class HTMLBasedPlayer extends StatefulWidget {
  const HTMLBasedPlayer({
    super.key,
    required this.webIdentifier,
    required this.source,
  });

  final String webIdentifier;
  final String source;

  @override
  State<HTMLBasedPlayer> createState() => _HTMLBasedPlayerState();
}

class _HTMLBasedPlayerState extends State<HTMLBasedPlayer> {
  late final String _platformViewID;
  late final HTMLVideoSetup _videoSetup;
  VideoElement? _controller;
  bool _showThumbnail = true;
  bool _isInitialized = false;
  bool _isViewRegistered = false;

  @override
  void initState() {
    super.initState();
    _videoSetup = HTMLVideoSetup();
    _platformViewID = widget.webIdentifier;
    _registerViewFactory();
  }

  void _registerViewFactory() {
    // Register the view factory only once
    if (!_isViewRegistered) {
      _isViewRegistered = ui.platformViewRegistry
          .registerViewFactory(_platformViewID, _createVideoElement);
    }
  }

  // Separate callback for creating the video element
  VideoElement _createVideoElement(int viewId) {
    final controller = _videoSetup.createVideoElement(widget.source);

    controller.addEventListener('play', (event) {
      if (_showThumbnail && mounted) {
        setState(() {
          _showThumbnail = false;
        });
      }
    });

    // Set controller and initialized flag
    // Use Future.microtask to avoid setState during build
    Future<void>.microtask(() {
      if (mounted) {
        setState(() {
          _controller = controller;
          _isInitialized = true;
        });
      }
    });

    return controller;
  }

  @override
  void dispose() {
    if (_isInitialized && _controller != null) {
      _controller!.remove();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: HtmlElementView(viewType: _platformViewID),
        ),
      ),
    );
  }
}
