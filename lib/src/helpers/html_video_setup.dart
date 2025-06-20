import 'package:universal_html/html.dart' as html;

class HTMLVideoSetup {
  factory HTMLVideoSetup() {
    _videoSetup ??= HTMLVideoSetup._internal();
    return _videoSetup!;
  }
  HTMLVideoSetup._internal();
  static HTMLVideoSetup? _videoSetup;

  html.VideoElement createVideoElement(String src) {
    return html.VideoElement()
      ..controls = true
      ..src = src
      ..preload = 'auto'
      ..style.width = '100%'
      ..style.height = '100%'
      ..poster =
          "assets/assets/images/thumbnails/video_thumbnail_placeholder.png"
      ..setAttribute('playsInline', 'true')
      ..setAttribute('controlsList', 'nodownload')
      ..setAttribute('oncontextmenu', 'return false;');
  }
}
