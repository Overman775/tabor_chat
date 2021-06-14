import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../chat/chat.dart';
import '../../../initialization/initialization.dart';
import '../../rooms.dart';

class AddChat extends StatefulWidget {
  const AddChat({Key? key}) : super(key: key);

  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  late GlobalKey<FormState> _formKey;
  late InitializedSettings _settings;
  late TextEditingController _newChatTextFieldController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
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
  void sendDialogResult(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_newChatTextFieldController.text);
    }
  }

  String? _roomNameValidator(String? text) {
    if (text == null || text.trim().length < 3) {
      return LocaleKeys.rooms_new_chat_dialog_errors_min_length_name.tr();
    }
  }

  Future<String?> _displayDialog(BuildContext context) async {
    return showDialog<String?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(LocaleKeys.rooms_new_chat_dialog_title.tr()),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _newChatTextFieldController,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(hintText: LocaleKeys.rooms_new_chat_dialog_hint.tr()),
                onEditingComplete: () => sendDialogResult(context),
                inputFormatters: <TextInputFormatter>[LengthLimitingTextInputFormatter(_settings.maxRoomTitleLength)],
                validator: _roomNameValidator,
              ),
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
