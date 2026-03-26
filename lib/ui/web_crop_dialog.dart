import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:neom_commons/ui/theme/app_color.dart';
import 'package:neom_commons/utils/constants/translations/app_translation_constants.dart';
import 'package:sint/sint.dart';

import '../utils/constants/image_editor_translation_constants.dart';

/// Shows a dialog with crop_your_image for web.
/// Returns cropped [Uint8List] or null if cancelled.
Future<Uint8List?> showWebCropDialog(
  BuildContext context,
  Uint8List imageBytes, {
  double aspectRatio = 1.0,
}) async {
  return showDialog<Uint8List?>(
    context: context,
    barrierColor: Colors.black87,
    barrierDismissible: false,
    builder: (_) => _WebCropDialog(imageBytes: imageBytes, aspectRatio: aspectRatio),
  );
}

class _WebCropDialog extends StatefulWidget {
  final Uint8List imageBytes;
  final double aspectRatio;

  const _WebCropDialog({required this.imageBytes, required this.aspectRatio});

  @override
  State<_WebCropDialog> createState() => _WebCropDialogState();
}

class _WebCropDialogState extends State<_WebCropDialog> {
  final CropController _cropController = CropController();
  bool _isCropping = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(40),
      child: Container(
        width: 800,
        height: 650,
        decoration: BoxDecoration(
          color: AppColor.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Header
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70, size: 22),
                    onPressed: () => Navigator.of(context).pop(null),
                  ),
                  Expanded(
                    child: Text(
                      ImageEditorTranslationConstants.adjustImage.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: _isCropping ? null : () {
                      setState(() => _isCropping = true);
                      _cropController.crop();
                    },
                    child: Text(
                      AppTranslationConstants.done.tr,
                      style: TextStyle(
                        color: _isCropping ? Colors.grey : AppColor.bondiBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.white12),
            // Crop area
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Crop(
                      image: widget.imageBytes,
                      controller: _cropController,
                      aspectRatio: widget.aspectRatio,
                      withCircleUi: false,
                      baseColor: Colors.black,
                      maskColor: Colors.black54,
                      cornerDotBuilder: (size, edgeAlignment) => Container(
                        width: size,
                        height: size,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      onCropped: (croppedBytes) {
                        Navigator.of(context).pop(croppedBytes);
                      },
                    ),
                  ),
                  if (_isCropping)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
