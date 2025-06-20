import 'package:chewie/src/helpers/fullscreen/fullscreen_utils_interface.dart';

class FullscreenUtils implements FullscreenUtilsInterface {
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
