// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/network/network.dart' as _i6;
import '../services/network/network_service_dio.dart' as _i7;
import '../services/router_service.dart' as _i4;
import '../theme/bloc/theme_bloc.dart' as _i5;
import 'injection_modules.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt init(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final injectionModules = _$InjectionModules();
    gh.lazySingleton<_i3.Connectivity>(() => injectionModules.connectivity());
    gh.factory<String>(() => injectionModules.baseUrl, instanceName: 'baseUrl');
    gh.factory<String>(() => injectionModules.socketUrl,
        instanceName: 'socketUrl');
    gh.singleton<_i4.RouterService>(_i4.RouterService());
    gh.singleton<_i5.ThemeBloc>(_i5.ThemeBloc());
    gh.singleton<_i6.NetworkService>(_i7.NetworkServiceDio.injectorFactory(
        get<_i3.Connectivity>(), get<String>(instanceName: 'baseUrl')));
    return this;
  }
}

class _$InjectionModules extends _i8.InjectionModules {}
