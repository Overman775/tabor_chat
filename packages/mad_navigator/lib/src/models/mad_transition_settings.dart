import 'package:flutter/widgets.dart';

import '../transition/router_page_transition.dart';

class MadTransitionSettings {
  const MadTransitionSettings({
    this.pageTransition = RouteTransitionType.native,
    this.transitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.maintainState = true,
  });

  final RouteTransitionType pageTransition;
  final RouteTransitionsBuilder? transitionsBuilder;
  final Duration transitionDuration;
  final bool maintainState;

  @override
  String toString() {
    return 'MadTransitionSettings(pageTransition: $pageTransition, transitionsBuilder: $transitionsBuilder, transitionDuration: $transitionDuration, maintainState: $maintainState)';
  }
}
