import 'package:json_annotation/json_annotation.dart';

part 'initialized_settings.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class InitializedSettings {
  InitializedSettings({
    required this.maxMessageLength,
    required this.maxRoomTitleLength,
    required this.maxUsernameLength,
  });

  factory InitializedSettings.fromJson(Map<String, dynamic> json) => _$InitializedSettingsFromJson(json);

  final int maxMessageLength;
  final int maxRoomTitleLength;
  final int maxUsernameLength;
}
