import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';
import 'package:tabor_chat/core/core.dart';

import '../../chat.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc({
    required this.repository,
    required this.roomName,
    required this.userName,
  }) : super(RoomInitial());

  late StreamSubscription<dynamic> _chatSubscription;
  late List<RoomMessage> _messages;

  final ChatRepository repository;
  final String roomName;
  final String userName;

  void _chatListener(Map<String, dynamic> value) {
    final RoomMessage message = RoomMessage.fromJson(value);
    if (message.room == roomName) {
      add(_MessageFromRoomEvent(message));
    }
  }

  void _chatSubscribe() {
    _chatSubscription = repository.chatStream.listen(_chatListener, cancelOnError: false);
  }

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    if (event is GetRoomEvent) {
      yield RoomLoadingState();
      final List<RoomMessage> history = await repository.loadHistory(event.roomName);
      _messages = history.reversed.toList();
      yield RoomMessagesState(messages: _messages);
      _chatSubscribe();
    } else if (event is _MessageFromRoomEvent) {
      yield* _addMessage(event.message);
    } else if (event is SendMessageRoomEvent) {
      yield* _sendMessage(event.message);
    }
  }

  Stream<RoomMessagesState> _sendMessage(RoomMessageRequest message) async* {
    repository.chatSink.add(message.toJson());

    final RoomMessage roomMessage = RoomMessage(
      room: roomName,
      text: message.text,
      created: DateTime.now(),
      id: message.id,
      sender: RoomMessageSender(username: userName),
    );

    yield* _addMessage(roomMessage);
  }

  Stream<RoomMessagesState> _addMessage(RoomMessage message) async* {
    _messages.insert(0, message);
    yield RoomMessagesState(messages: _messages);
  }

  @override
  Future<void> close() {
    _chatSubscription.cancel();
    return super.close();
  }
}
