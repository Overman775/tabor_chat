import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:mad_navigator/mad_navigator.dart';
import 'package:tabor_chat/features/chat/chat.dart';

import '../../features/common/common.dart';
import '../../features/initialization/initialization.dart';
import '../../features/login/login.dart';
import '../../features/rooms/rooms.dart';
import '../core.dart';

@singleton
class RouterService extends MadNavigatorService {
  @override
  MadRouter homeRouter = AppRouter();

  @override
  MadPage unknownPage = MadPage(
    name: '/unknown',
    pageBuilder: ({MadPageParams? params}) => const UnknownPage(),
  );

  @override
  List<MadTab> routerTabs = <MadTab>[];
}

class AppRouter extends MadRouter {
  @override
  String initialRoute = InitializationRoutes.initialization;

  @override
  NavigatorObserver observer = MadHistory();

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  List<MadPage> routes = <MadPage>[
    ...InitializationRoutes.routes,
    ...LoginRoutes.routes,
    ...RoomsRoutes.routes,
    ...ChatRoutes.routes,
  ];
}
