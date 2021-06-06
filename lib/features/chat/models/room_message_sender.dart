import 'package:json_annotation/json_annotation.dart';

part 'room_message_sender.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class RoomMessageSender {
  const RoomMessageSender({
    required this.username,
  });

  factory RoomMessageSender.fromJson(Map<String, dynamic> json) => _$RoomMessageSenderFromJson(json);

  final String username;
}
