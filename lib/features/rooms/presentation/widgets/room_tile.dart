import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/core.dart';
import '../../../chat/chat.dart';
import '../../rooms.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({Key? key, required this.room}) : super(key: key);

  final Room room;

  void _onTap(BuildContext context) {
    injector.get<RouterService>().go(
          ChatRoutes.chat,
          arguments: ChatPageArguments(roomName: room.name),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: ListTile(
        title: Text(room.name),
      ),
    );
  }
}
