part of 'router_page_transition.dart';

Route<dynamic> _materialPageRoute(MadPage page, RouteSettings? routeSettings) {
  return MaterialPageRoute<dynamic>(
    settings: routeSettings,
    fullscreenDialog: page.transitionSettings.pageTransition == RouteTransitionType.nativeModal,
    maintainState: page.transitionSettings.maintainState,
    builder: (BuildContext context) => page.pageBuilder(params: routeSettings?.arguments as MadPageParams?),
  );
}
