import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_message_request.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class RoomMessageRequest extends Equatable {
  const RoomMessageRequest({
    required this.room,
    required this.text,
    this.id,
  });

  Map<String, dynamic> toJson() => _$RoomMessageRequestToJson(this);

  final String room;
  final String text;
  @JsonKey(includeIfNull: false)
  final String? id;

  @override
  List<Object?> get props => <Object?>[room, text, id];
}
