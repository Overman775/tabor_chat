import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../common/common.dart';
import '../../chat.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, required this.arguments}) : super(key: key);

  final ChatPageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.roomName),
      ),
      body: BlocProvider<RoomBloc>(
        create: (_) => RoomBloc(
          repository: injector.get(),
          roomName: arguments.roomName,
          userName: injector.get<String>(instanceName: 'userName'),
        )..add(GetRoomEvent(roomName: arguments.roomName)),
        lazy: false,
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (BuildContext context, RoomState state) {
        if (state is RoomLoadingState) {
          return const _Room();
        } else if (state is RoomMessagesState) {
          return _ChatList(messages: state.messages);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _Room extends StatelessWidget {
  const _Room({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: DefaultPreloader(),
    );
  }
}

class _ChatList extends StatefulWidget {
  const _ChatList({Key? key, required this.messages}) : super(key: key);

  final List<RoomMessage> messages;

  @override
  __ChatListState createState() => __ChatListState();
}

class __ChatListState extends State<_ChatList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isSender(RoomMessage message, String userName) => message.sender.username == userName;

  @override
  Widget build(BuildContext context) {
    final String userName = injector.get<String>(instanceName: 'userName');

    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.messages.length,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        return MessageTile(
          key: Key('RoomMessage_${widget.messages[index].hashCode}'),
          message: widget.messages[index],
          isSender: isSender(widget.messages[index], userName),
        );
      },
    );
  }
}
