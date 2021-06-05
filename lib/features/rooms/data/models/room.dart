import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Room {
  Room({
    required this.name,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  final String name;
}
