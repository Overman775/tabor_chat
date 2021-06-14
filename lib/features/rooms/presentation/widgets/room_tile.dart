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
        leading: CircleAvatar(
          backgroundColor: context.colors.secondary,
          child: Text(
            room.name[0].toUpperCase(),
            style: TextStyle(color: context.colors.onSecondary),
          ),
        ),
        trailing: _getFormattedDate(context),
        title: Text(room.name),
      ),
    );
  }

  Widget _getFormattedDate(BuildContext context) {
    final DateTime? created = room.lastMessage?.created;
    if (created != null) {
      final DateFormat formatter = DateFormat.yMMMMd(context.locale.toLanguageTag()).add_Hm();
      return Text(
        formatter.format(room.lastMessage!.created),
        style: TextStyle(color: context.colors.primaryVariant),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
