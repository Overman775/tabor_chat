import '../interfaces/mad_tab_interface.dart';
import '../models/mad_router.dart';

abstract class MadTab extends MadRouter implements MadTabInterface {
  @override
  String toString() => 'MadTab(name: $name, icon: $icon, initialRoute: $initialRoute, routes: $routes)';

  String toStringShort() => name;
}
