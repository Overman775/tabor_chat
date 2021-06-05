import '../../models/initialized_settings.dart';

abstract class InitializationPreloaderRepository {
  Future<InitializedSettings> loadSettings();
}
