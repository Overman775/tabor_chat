import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

import '../../mad_navigator.dart';
import '../interfaces/mad_router_interface.dart';
import '../transition/router_page_transition.dart';
import 'mad_page.dart';

abstract class MadRouter implements MadRouterInterface {
  @override
  Route<dynamic>? generateRoute(RouteSettings settings) {
    final MadPage? page = searchPage(settings.name!);

    if (page != null) {
      return routeBuilder(page, routeSettings: settings);
    } else {
      return null;
    }
  }

  @override
  Route<dynamic> unknownRoute(RouteSettings settings) {
    final MadPage? page = searchPage(settings.name!);

    if (page != null) {
      return routeBuilder(page, routeSettings: settings);
    } else {
      return routeBuilder(MadNavigatorService.instance.unknownPage, routeSettings: settings);
    }
  }

  MadPage? searchPage(String name) => routes.firstWhereOrNull((MadPage e) => e.pathRegExp.hasMatch(name));

  @override
  String toString() => 'MadRouter(initialRoute: $initialRoute, routes: $routes)';
}
