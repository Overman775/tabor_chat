import 'package:connectivity/connectivity.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModules {
  @Named('baseUrl')
  String get baseUrl => 'https://nane.tada.team/api';

  @Named('socketUrl')
  String get socketUrl => 'wss://nane.tada.team/ws';

  @lazySingleton
  Connectivity connectivity() => Connectivity();
}
