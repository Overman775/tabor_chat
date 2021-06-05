import '../models/mad_page.dart';
import '../models/mad_router.dart';
import '../models/mad_tab.dart';

abstract class MadNavigatorInterface {
  /// Home router
  late MadRouter homeRouter;

  /// Collection of tabs with routers
  late List<MadTab> routerTabs;

  /// Generic page for unknown link
  late MadPage unknownPage;
}
