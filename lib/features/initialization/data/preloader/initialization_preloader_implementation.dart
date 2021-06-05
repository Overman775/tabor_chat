import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../models/initialized_settings.dart';
import 'initialization_preloader.dart';

@prod
@Injectable(as: InitializationPreloaderService)
class InitializationPreloaderImplementationService implements InitializationPreloaderService {
  InitializationPreloaderImplementationService({required this.network});

  final NetworkService network;

  @override
  Future<InitializedSettings> loadSettings() async {
    final Map<String, dynamic>? result = await network.get<Map<String, dynamic>>('/settings');

    if (result?['result'] != null) {
      return InitializedSettings.fromJson(result!['result'] as Map<String, dynamic>);
    } else {
      throw 'Settings not loaded';
    }
  }
}
