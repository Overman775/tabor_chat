import 'package:mad_navigator/mad_navigator.dart';

import 'login.dart';

class LoginRoutes {
  static const String login = 'login/';

  static List<MadPage> routes = <MadPage>[
    MadPage(
      name: LoginRoutes.login,
      pageBuilder: ({MadPageParams? params}) => const LoginPage(),
    ),
  ];
}
