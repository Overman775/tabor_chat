// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RoomMessageRequestToJson(RoomMessageRequest instance) {
  final val = <String, dynamic>{
    'room': instance.room,
    'text': instance.text,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
