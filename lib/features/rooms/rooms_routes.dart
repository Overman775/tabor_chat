import 'package:mad_navigator/mad_navigator.dart';

import 'rooms.dart';

class RoomsRoutes {
  static const String rooms = 'rooms/';

  static List<MadPage> routes = <MadPage>[
    MadPage(name: RoomsRoutes.rooms, pageBuilder: ({MadPageParams? params}) => const RoomsPage()),
  ];
}
