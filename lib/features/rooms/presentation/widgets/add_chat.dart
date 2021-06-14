import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tabor_chat/features/initialization/initialization.dart';

import '../../../../core/core.dart';
import '../../../chat/chat.dart';
import '../../rooms.dart';

class AddChat extends StatefulWidget {
  const AddChat({Key? key}) : super(key: key);

  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  late InitializedSettings _settings;
  late TextEditingController _newChatTextFieldController;

  @override
  void initState() {
    _settings = injector.get();
    _newChatTextFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _newChatTextFieldController.dispose();
    super.dispose();
  }

  void closeDialog(BuildContext context) => Navigator.of(context).pop();
  void sendDialogResult(BuildContext context) => Navigator.of(context).pop(_newChatTextFieldController.text);

  Future<String?> _displayDialog(BuildContext context) async {
    return showDialog<String?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(LocaleKeys.rooms_new_chat_dialog_title.tr()),
            content: TextField(
              controller: _newChatTextFieldController,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(hintText: LocaleKeys.rooms_new_chat_dialog_hint.tr()),
              onEditingComplete: () => sendDialogResult(context),
              inputFormatters: <TextInputFormatter>[LengthLimitingTextInputFormatter(_settings.maxRoomTitleLength)],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => closeDialog(context),
                child: Text(LocaleKeys.rooms_new_chat_dialog_cancel.tr()),
              ),
              TextButton(
                onPressed: () => sendDialogResult(context),
                child: Text(LocaleKeys.rooms_new_chat_dialog_ok.tr()),
              ),
            ],
          );
        });
  }

  Future<void> _newChat() async {
    final String? roomName = await _displayDialog(context);

    if (roomName != null) {
      context.read<RoomsBloc>().add(NewRoomsEvent(roomName));
      injector.get<RouterService>().go(
            ChatRoutes.chat,
            arguments: ChatPageArguments(roomName: roomName, isNewChat: true),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _newChat();
      },
      child: const Icon(Icons.add),
    );
  }
}
