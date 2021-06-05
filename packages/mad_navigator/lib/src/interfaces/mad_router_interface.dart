import 'package:flutter/widgets.dart';

import '../models/mad_page.dart';

abstract class MadRouterInterface {
  late String initialRoute;
  late GlobalKey<NavigatorState> navigatorKey;
  late List<MadPage> routes;
  late NavigatorObserver observer;

  Route<dynamic>? generateRoute(RouteSettings settings);
  Route<dynamic> unknownRoute(RouteSettings settings);
}
