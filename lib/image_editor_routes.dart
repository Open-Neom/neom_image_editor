import 'package:sint/sint.dart';

import 'package:neom_core/utils/constants/app_route_constants.dart';
import 'package:neom_core/ui/deferred_loader.dart';

import 'ui/pro_image_editor_page.dart' deferred as imgEditor;

class ImageEditorRoutes {

  static final List<SintPage<dynamic>> routes = [
    SintPage(
      name: AppRouteConstants.imageEditor,
      page: () => DeferredLoader(imgEditor.loadLibrary, () => imgEditor.ProImageEditorPage(
        onEditingComplete: (_) {},
      )),
      transition: Transition.zoom,
    ),
  ];

}
