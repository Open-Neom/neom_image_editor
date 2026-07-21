import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:neom_commons/ui/theme/app_color.dart';
import 'package:neom_core/app_config.dart';
import 'package:neom_core/utils/neom_error_logger.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

/// Full-featured image editor powered by pro_image_editor.
/// Supports: paint, text, crop/rotate, filters, blur, emoji, stickers, undo/redo.
class ProImageEditorPage extends StatelessWidget {
  const ProImageEditorPage({
    super.key,
    this.imageBytes,
    this.imageUrl,
    this.imageFile,
    required this.onEditingComplete,
  }) : assert(imageBytes != null || imageUrl != null || imageFile != null,
          'Provide imageBytes, imageUrl, or imageFile');

  final Uint8List? imageBytes;
  final String? imageUrl;
  final dynamic imageFile;
  final void Function(Uint8List editedBytes) onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final callbacks = ProImageEditorCallbacks(
      onImageEditingComplete: (Uint8List bytes) async {
        AppConfig.logger.i('Image editing complete: ${bytes.length} bytes');
        onEditingComplete(bytes);
        if (context.mounted) Navigator.of(context).pop();
      },
    );

    final configs = ProImageEditorConfigs(
      imageGeneration: const ImageGenerationConfigs(
        outputFormat: OutputFormat.jpg,
        maxOutputSize: Size(1920, 1080),
        processorConfigs: ProcessorConfigs(
          processorMode: ProcessorMode.minimum,
        ),
      ),
    );

    try {
      if (imageBytes != null) {
        return ProImageEditor.memory(
          imageBytes!,
          callbacks: callbacks,
          configs: configs,
        );
      } else if (imageUrl != null) {
        return ProImageEditor.network(
          imageUrl!,
          callbacks: callbacks,
          configs: configs,
        );
      } else {
        return ProImageEditor.file(
          imageFile!,
          callbacks: callbacks,
          configs: configs,
        );
      }
    } catch (e, st) {
      NeomErrorLogger.recordError(e, st,
          module: 'neom_image_editor', operation: 'ProImageEditorPage.build');
      return Scaffold(
        backgroundColor: AppColor.scaffold,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.white54, size: 48),
              const SizedBox(height: 16),
              const Text('Error loading image editor',
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go back'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
