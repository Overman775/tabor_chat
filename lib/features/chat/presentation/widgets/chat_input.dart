import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/core.dart';
import '../../chat.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  late RoomBloc roomBloc;

  final TextEditingController _messageTextController = TextEditingController();

  @override
  void dispose() {
    _messageTextController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    roomBloc = context.read<RoomBloc>();
  }

  void _onSendMessage() {
    roomBloc.add(SendMessageRoomEvent(_messageTextController.text));
    _messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Ds.defaultMargin),
      child: SizedBox(
        height: 80,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _messageTextController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.chat_input_hint.tr(),
                ),
                inputFormatters: <TextInputFormatter>[LengthLimitingTextInputFormatter(255)],
                onSubmitted: (_) => _onSendMessage(),
                textInputAction: TextInputAction.send,
                onEditingComplete: () {},
              ),
            ),
            const SizedBox(width: Ds.defaultMarginHalf),
            IconButton(
              icon: const Icon(Icons.send),
              color: context.colors.secondary,
              onPressed: _onSendMessage,
              // color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
