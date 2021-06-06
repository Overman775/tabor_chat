// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomMessage _$RoomMessageFromJson(Map<String, dynamic> json) {
  return RoomMessage(
    room: json['room'] as String,
    text: json['text'] as String,
    id: json['id'] as String?,
    created: RoomMessage._dateTimeParser(json['created'] as String),
    sender: RoomMessageSender.fromJson(json['sender'] as Map<String, dynamic>),
  );
}
