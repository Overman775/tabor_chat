// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RoomMessageRequestToJson(RoomMessageRequest instance) {
  final val = <String, dynamic>{
    'stringify': instance.stringify,
    'hash_code': instance.hashCode,
    'room': instance.room,
    'text': instance.text,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['props'] = instance.props;
  return val;
}
