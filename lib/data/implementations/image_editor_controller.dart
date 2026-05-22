import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neom_core/utils/platform/core_io.dart';
import 'package:neom_commons/ui/theme/app_color.dart';
import 'package:neom_commons/utils/constants/translations/app_translation_constants.dart';
import 'package:neom_core/app_config.dart';
import 'package:neom_core/utils/neom_error_logger.dart';
import 'package:neom_core/domain/use_cases/image_editor_service.dart';
import 'package:sint/sint.dart';

import '../../ui/pro_image_editor_page.dart';
import '../../ui/web_crop_dialog.dart';
import '../../utils/constants/image_editor_translation_constants.dart';
import 'background_remover_controller.dart';

class ImageEditorController implements ImageEditorService {

  final BackgroundRemoverController _bgRemover = BackgroundRemoverController();

  @override
  Future<File?> cropImage(File file, {double ratioX = 1, double ratioY = 1}) async {
    AppConfig.logger.d("Initializing Image Cropper");

    File? croppedImageFile;

    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(
            ratioX: ratioX,
            ratioY: ratioY
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: ImageEditorTranslationConstants.adjustImage.tr,
            backgroundColor: AppColor.scaffold,
            toolbarColor: AppColor.getMain(),
            toolbarWidgetColor: AppColor.white,
            statusBarColor: AppColor.getMain(),
            dimmedLayerColor: AppColor.surfaceCard,
            activeControlsWidgetColor: AppColor.yellow,
            hideBottomControls: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          ),
          IOSUiSettings(
            title: ImageEditorTranslationConstants.adjustImage.tr,
            cancelButtonTitle: AppTranslationConstants.cancel.tr,
            doneButtonTitle: AppTranslationConstants.done.tr,
            minimumAspectRatio: 1.0,
            showCancelConfirmationDialog: true,
            aspectRatioLockEnabled: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          )
        ],
      );

      if(croppedFile?.path.isNotEmpty ?? false) {
        croppedImageFile = File(croppedFile!.path);
        AppConfig.logger.d("Cropped Image in file ${croppedImageFile.path}");
      } else {
        AppConfig.logger.w("Cropped file is empty or null");
      }

    } catch (e, st) {
      NeomErrorLogger.recordError(e, st, module: 'neom_image_editor', operation: 'cropImage');
    }

    return croppedImageFile;
  }

  @override
  Future<Uint8List?> cropImageBytes(BuildContext context, Uint8List bytes, {double aspectRatio = 1.0}) async {
    AppConfig.logger.d("Initializing Web Image Cropper");
    try {
      return await showWebCropDialog(context, bytes, aspectRatio: aspectRatio);
    } catch (e, st) {
      NeomErrorLogger.recordError(e, st, module: 'neom_image_editor', operation: 'cropImageBytes');
    }
    return null;
  }

  @override
  Future<Uint8List?> openFullEditor(BuildContext context, {Uint8List? imageBytes, String? imageUrl}) async {
    AppConfig.logger.d("Opening Pro Image Editor");
    try {
      final completer = Completer<Uint8List?>();

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProImageEditorPage(
            imageBytes: imageBytes,
            imageUrl: imageUrl,
            onEditingComplete: (bytes) => completer.complete(bytes),
          ),
        ),
      );

      if (!completer.isCompleted) completer.complete(null);
      return await completer.future;
    } catch (e, st) {
      NeomErrorLogger.recordError(e, st, module: 'neom_image_editor', operation: 'openFullEditor');
    }
    return null;
  }

  @override
  Future<Uint8List?> removeBackground(Uint8List imageBytes) async {
    AppConfig.logger.d("Removing image background with AI");
    try {
      return await _bgRemover.removeBackground(imageBytes);
    } catch (e, st) {
      NeomErrorLogger.recordError(e, st, module: 'neom_image_editor', operation: 'removeBackground');
    }
    return null;
  }

  void dispose() {
    _bgRemover.dispose();
  }

}
