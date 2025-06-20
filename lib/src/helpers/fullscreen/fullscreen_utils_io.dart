import 'package:chewie/src/helpers/fullscreen/fullscreen_utils_interface.dart';

class FullscreenUtils implements FullscreenUtilsInterface {
  // Factory method to return the singleton instance
  factory FullscreenUtils() => _singleton;
  // Private constructor
  FullscreenUtils._internal();

  // Singleton instance
  static final FullscreenUtils _singleton = FullscreenUtils._internal();

  @override
  bool isSafariMobile() {
    return false;
  }

  @override
  void enterFullscreen() {}

  @override
  void exitFullscreen() {}

  /// Retrieves the value of a specific cookie by its name.
  @override
  bool isFullscreen() {
    return false;
  }
}
