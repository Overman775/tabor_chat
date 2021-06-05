import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt injector = GetIt.instance;

@InjectableInit(
  asExtension: true,
  initializerName: 'init',
)
GetIt configInjector({
  String? env,
  EnvironmentFilter? environmentFilter,
}) {
  return injector.init(
    environmentFilter: environmentFilter,
    environment: env,
  );
}
