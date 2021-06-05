import 'package:flutter/widgets.dart';

import '../../mad_navigator.dart';

class MadNavigator extends StatelessWidget {
  const MadNavigator({
    Key? key,
    this.observers = const <NavigatorObserver>[],
  }) : super(key: key);

  final List<NavigatorObserver> observers;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: MadNavigatorService.instance.onWillPop,
      child: Navigator(
        // Интеграция сервиса роутера
        key: MadNavigatorService.instance.homeRouter.navigatorKey,
        initialRoute: MadNavigatorService.instance.homeRouter.initialRoute,
        onGenerateRoute: MadNavigatorService.instance.homeRouter.generateRoute,
        observers: observers,
      ),
    );
  }
}
