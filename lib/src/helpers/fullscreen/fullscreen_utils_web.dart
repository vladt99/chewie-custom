// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'fullscreen_utils_interface.dart';

class FullscreenUtils implements FullscreenUtilsInterface {
  // Factory method to return the singleton instance
  factory FullscreenUtils() => _singleton;
  // Private constructor
  FullscreenUtils._internal();

  // Singleton instance
  static final FullscreenUtils _singleton = FullscreenUtils._internal();

  @override
  bool isSafariMobile() {
    return _isSafariMobile;
  }

  static bool get _isSafariMobile {
    return RegExp(
      r'(\s|^)AppleWebKit/[\d\.]+\s+\(.+\)\s+Version/(1[0-9]|[2-9][0-9]|\d{3,})(\.|$|\s)',
    ).hasMatch(window.navigator.userAgent);
  }

  @override
  void enterFullscreen() {
    if (_isSafariMobile) {
      return;
    }
    document.documentElement?.requestFullscreen();
  }

  @override
  void exitFullscreen() {
    document.exitFullscreen();
  }

  @override
  bool isFullscreen() {
    if (_isSafariMobile) {
      return false;
    }
    return document.fullscreenElement != null;
  }
}
