// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
    name: json['name'] as String,
    lastMessage: json['last_message'] == null
        ? null
        : RoomMessage.fromJson(json['last_message'] as Map<String, dynamic>),
  );
}
