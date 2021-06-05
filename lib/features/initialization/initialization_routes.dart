import 'package:mad_navigator/mad_navigator.dart';

import 'initialization.dart';

class InitializationRoutes {
  static const String initialization = 'initialization/';

  static List<MadPage> routes = <MadPage>[
    MadPage(
        name: InitializationRoutes.initialization,
        pageBuilder: ({MadPageParams? params}) => const InitializationPage()),
  ];
}
