import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../chat/chat.dart';

part 'room.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Room extends Equatable {
  const Room({
    required this.name,
    this.lastMessage,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  final String name;
  final RoomMessage? lastMessage;

  Room copyWith({
    String? name,
    RoomMessage? lastMessage,
  }) {
    return Room(
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[name, lastMessage];
}
