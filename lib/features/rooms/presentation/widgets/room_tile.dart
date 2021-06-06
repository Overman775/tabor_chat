import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../rooms.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({Key? key, required this.room}) : super(key: key);

  final Room room;

  void _onTap() {
    print(room.name);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: ListTile(
        title: Text(room.name),
      ),
    );
  }
}
