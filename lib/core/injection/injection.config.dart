// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/chat/data/chat_repository/chat_repository.dart' as _i7;
import '../../features/chat/data/chat_repository/chat_repository_implementation.dart'
    as _i8;
import '../../features/initialization/data/preloader/initialization_preloader.dart'
    as _i4;
import '../../features/initialization/data/preloader/initialization_preloader_implementation.dart'
    as _i5;
import '../../features/rooms/data/rooms_repository/rooms_repository.dart'
    as _i9;
import '../../features/rooms/data/rooms_repository/rooms_repository_implementation.dart'
    as _i10;
import '../core.dart' as _i6;
import '../services/network/network.dart' as _i14;
import '../services/network/network_service_dio.dart' as _i15;
import '../services/router_service.dart' as _i11;
import '../services/socket/socket_service_implementation.dart' as _i12;
import '../theme/bloc/theme_bloc.dart' as _i13;
import 'injection_modules.dart' as _i16;

const String _prod = 'prod';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt init(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final injectionModules = _$InjectionModules();
    gh.lazySingleton<_i3.Connectivity>(() => injectionModules.connectivity());
    gh.factory<_i4.InitializationPreloaderRepository>(
        () => _i5.InitializationPreloaderImplementationService(
            network: get<_i6.NetworkService>()),
        registerFor: {_prod});
    gh.factory<String>(() => injectionModules.baseUrl, instanceName: 'baseUrl');
    gh.factory<String>(() => injectionModules.socketUrl,
        instanceName: 'socketUrl');
    gh.factory<_i7.ChatRepository>(
        () => _i8.ChatRepositoryImplementation(
            network: get<_i6.NetworkService>(),
            socketService: get<_i6.SocketService>()),
        registerFor: {_prod});
    gh.factory<_i9.RoomsRepository>(
        () => _i10.RoomsRepositoryImplementation(
            network: get<_i6.NetworkService>(),
            socketService: get<_i6.SocketService>()),
        registerFor: {_prod});
    gh.singleton<_i11.RouterService>(_i11.RouterService());
    gh.singleton<_i6.SocketService>(_i12.SocketServiceImplementation());
    gh.singleton<_i13.ThemeBloc>(_i13.ThemeBloc());
    gh.singleton<_i14.NetworkService>(_i15.NetworkServiceDio.injectorFactory(
        get<_i3.Connectivity>(), get<String>(instanceName: 'baseUrl')));
    return this;
  }
}

class _$InjectionModules extends _i16.InjectionModules {}
