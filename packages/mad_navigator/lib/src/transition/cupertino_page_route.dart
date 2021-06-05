part of 'router_page_transition.dart';

Route<dynamic> _cupertinoPageRoute(MadPage page, RouteSettings? routeSettings) {
  return CupertinoPageRoute<dynamic>(
    settings: routeSettings,
    fullscreenDialog: page.transitionSettings.pageTransition == RouteTransitionType.nativeModal,
    maintainState: page.transitionSettings.maintainState,
    builder: (BuildContext context) => page.pageBuilder(params: routeSettings?.arguments as MadPageParams?),
  );
}
