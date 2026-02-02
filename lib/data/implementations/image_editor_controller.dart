import 'dart:io';

import 'package:sint/sint.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neom_commons/ui/theme/app_color.dart';
import 'package:neom_commons/utils/constants/translations/app_translation_constants.dart';
import 'package:neom_core/app_config.dart';
import 'package:neom_core/domain/use_cases/image_editor_service.dart';

import '../../utils/constants/image_editor_translation_constants.dart';

class ImageEditorController implements ImageEditorService {

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
            backgroundColor: AppColor.getMain(),
            toolbarColor: AppColor.getMain(),
            toolbarWidgetColor: AppColor.white,
            statusBarColor: AppColor.getMain(),
            dimmedLayerColor: AppColor.main50,
            activeControlsWidgetColor: AppColor.yellow,
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

    } catch (e) {
      AppConfig.logger.e(e.toString());
    }

    return croppedImageFile;
  }

}
