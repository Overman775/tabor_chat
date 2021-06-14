import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    if (event is GetRoomHistoryEvent) {
      yield RoomLoadingState();
      final List<RoomMessage> history = await repository.loadHistory(event.roomName);
      _messages = history.reversed.toList();
      yield RoomMessagesState(messages: _messages);
      _chatSubscribe();
    } else if (event is GetRoomNewEvent) {
      _messages = <RoomMessage>[];
      yield RoomMessagesState(messages: _messages);
      _chatSubscribe();
    } else if (event is _MessageFromRoomEvent) {
      yield* _addMessage(event.message);
    } else if (event is SendMessageRoomEvent) {
      yield* _sendMessage(event.message);
    }
  }

  Stream<RoomMessagesState> _sendMessage(String message) async* {
    final RoomMessageRequest request = RoomMessageRequest(room: roomName, text: message);

    repository.chatSink.add(request.toJson());
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
