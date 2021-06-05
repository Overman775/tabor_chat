import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/mad_page.dart';
import '../models/mad_page_params.dart';

part 'cupertino_page_route.dart';
part 'material_page_route.dart';

Route<dynamic> routeBuilder(MadPage page, {RouteSettings? routeSettings}) {
  final bool isNative = page.transitionSettings.pageTransition == RouteTransitionType.native ||
      page.transitionSettings.pageTransition == RouteTransitionType.nativeModal;

  if (Platform.isIOS && isNative) {
    return _cupertinoPageRoute(page, routeSettings);
  }

  if (isNative) {
    return _materialPageRoute(page, routeSettings);
  }

  if (page.transitionSettings.pageTransition == RouteTransitionType.material ||
      page.transitionSettings.pageTransition == RouteTransitionType.materialFullScreen) {
    return _materialPageRoute(page, routeSettings);
  }

  if (page.transitionSettings.pageTransition == RouteTransitionType.cupertino ||
      page.transitionSettings.pageTransition == RouteTransitionType.cupertinoFullScreen) {
    return _cupertinoPageRoute(page, routeSettings);
  }

  late RouteTransitionsBuilder routeTransitionsBuilder;

  if (page.transitionSettings.pageTransition == RouteTransitionType.custom &&
      page.transitionSettings.transitionsBuilder != null) {
    routeTransitionsBuilder = page.transitionSettings.transitionsBuilder!;
  } else {
    routeTransitionsBuilder = _defaultTransitionsBuilder(page.transitionSettings.pageTransition);
  }

  return PageRouteBuilder<dynamic>(
    settings: routeSettings,
    maintainState: page.transitionSettings.maintainState,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
        page.pageBuilder(params: routeSettings?.arguments as MadPageParams?),
    transitionDuration: page.transitionSettings.pageTransition == RouteTransitionType.none
        ? Duration.zero
        : page.transitionSettings.transitionDuration,
    reverseTransitionDuration: page.transitionSettings.pageTransition == RouteTransitionType.none
        ? Duration.zero
        : page.transitionSettings.transitionDuration,
    transitionsBuilder: page.transitionSettings.pageTransition == RouteTransitionType.none
        ? (_, __, ___, Widget child) => child
        : routeTransitionsBuilder,
  );
}

RouteTransitionsBuilder _defaultTransitionsBuilder(RouteTransitionType transitionType) {
  return (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (transitionType == RouteTransitionType.fadeIn) {
      return FadeTransition(opacity: animation, child: child);
    } else {
      const Offset topLeft = Offset(0.0, 0.0);
      const Offset topRight = Offset(1.0, 0.0);
      const Offset bottomLeft = Offset(0.0, 1.0);

      Offset startOffset = bottomLeft;
      Offset endOffset = topLeft;
      if (transitionType == RouteTransitionType.fromLeft) {
        startOffset = const Offset(-1.0, 0.0);
        endOffset = topLeft;
      } else if (transitionType == RouteTransitionType.fromRight) {
        startOffset = topRight;
        endOffset = topLeft;
      } else if (transitionType == RouteTransitionType.fromBottom) {
        startOffset = bottomLeft;
        endOffset = topLeft;
      } else if (transitionType == RouteTransitionType.fromTop) {
        startOffset = const Offset(0.0, -1.0);
        endOffset = topLeft;
      }

      return SlideTransition(
        position: Tween<Offset>(
          begin: startOffset,
          end: endOffset,
        ).animate(animation),
        child: child,
      );
    }
  };
}

enum RouteTransitionType {
  native,
  nativeModal,
  material,
  materialFullScreen,
  cupertino,
  cupertinoFullScreen,
  fromLeft,
  fromTop,
  fromRight,
  fromBottom,
  fadeIn,
  custom,
  none,
}
