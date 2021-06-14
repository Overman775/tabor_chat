import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'room_message_sender.dart';

part 'room_message.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class RoomMessage extends Equatable {
  const RoomMessage({
    required this.room,
    required this.text,
    this.id,
    required this.created,
    required this.sender,
  });

  factory RoomMessage.fromJson(Map<String, dynamic> json) => _$RoomMessageFromJson(json);

  final String room;
  final String text;
  final String? id;
  @JsonKey(fromJson: _dateTimeParser)
  final DateTime created;
  final RoomMessageSender sender;

  static DateTime _dateTimeParser(String value) => DateTime.parse(value);

  @override
  List<Object?> get props => <Object?>[room, text, id, created, sender];
}
