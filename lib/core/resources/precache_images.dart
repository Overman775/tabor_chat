import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

abstract class PrecacheImage {
  static Future<void> precache() => Future.wait(
        <Future<void>>[
          precachePicture(
            ExactAssetPicture(SvgPicture.svgStringDecoder, R.ASSETS_IMAGES_LOGO_SVG),
            null,
          ),
        ],
      );
}
