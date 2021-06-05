import 'package:flutter/widgets.dart';

import '../services/mad_navigator.dart';
import '../utils/utils.dart';

extension MadRouterStringExtension on String {
  Future<void> go({Object? arguments, RoutePredicate? removeUntil}) =>
      MadNavigatorService.instance.go(this, arguments: arguments, removeUntil: removeUntil);

  String params(Map<String, dynamic> params) => preparePath(this, params);
}
