import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image_background_remover/image_background_remover.dart';
import 'package:neom_core/app_config.dart';
import 'package:neom_core/utils/neom_error_logger.dart';

/// AI-powered background removal using ONNX model (fully offline).
/// Adds ~30MB to app size. Requires iOS 16.0+.
class BackgroundRemoverController {

  bool _isInitialized = false;

  /// Initialize the ONNX runtime. Call once before using removeBg.
  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      BackgroundRemover.instance.initializeOrt();
      _isInitialized = true;
      AppConfig.logger.i('BackgroundRemover ONNX runtime initialized');
    } catch (e, st) {
      NeomErrorLogger.recordError(e, st,
          module: 'neom_image_editor', operation: 'BackgroundRemover.initialize');
    }
  }

  /// Remove background from image bytes.
  /// Returns PNG bytes with transparent background, or null on failure.
  Future<Uint8List?> removeBackground(Uint8List imageBytes) async {
    try {
      if (!_isInitialized) await initialize();

      final ui.Image result = await BackgroundRemover.instance.removeBg(imageBytes);

      final byteData = await result.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        AppConfig.logger.w('Background removal returned null byteData');
        return null;
      }

      AppConfig.logger.i('Background removed successfully');
      return byteData.buffer.asUint8List();
    } catch (e, st) {
      NeomErrorLogger.recordError(e, st,
          module: 'neom_image_editor', operation: 'removeBackground');
      return null;
    }
  }

  /// Dispose the ONNX runtime resources.
  void dispose() {
    if (_isInitialized) {
      BackgroundRemover.instance.dispose();
      _isInitialized = false;
      AppConfig.logger.d('BackgroundRemover disposed');
    }
  }
}
