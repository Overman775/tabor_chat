import 'package:json_annotation/json_annotation.dart';
import '../../../chat/chat.dart';

part 'room.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Room {
  Room({
    required this.name,
    this.lastMessage,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  final String name;
  final RoomMessage? lastMessage;
}
