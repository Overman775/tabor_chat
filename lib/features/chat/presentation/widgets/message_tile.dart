import 'package:flutter/widgets.dart';

import '../../chat.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.message}) : super(key: key);

  final RoomMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message.text),
    );
  }
}
