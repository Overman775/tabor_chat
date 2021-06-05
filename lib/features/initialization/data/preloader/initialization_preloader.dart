import '../../models/initialized_settings.dart';

abstract class InitializationPreloaderService {
  Future<InitializedSettings> loadSettings();
}
