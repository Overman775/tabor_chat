import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

abstract class PrecacheImage {
  static Future<void> precache() => Future.wait(
        <Future<void>>[
          // precachePicture(
          //   ExactAssetPicture(SvgPicture.svgStringDecoder, ''),
          //   null,
          // ),
        ],
      );
}
