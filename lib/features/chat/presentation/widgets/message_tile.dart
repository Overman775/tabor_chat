import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabor_chat/core/core.dart';

import '../../chat.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final RoomMessage message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Ds.defaultMargin.sp, vertical: Ds.defaultMarginHalf.sp),
      child: Align(
        alignment: isSender ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSender ? context.colors.primaryLight : context.colors.primary,
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            message.text,
            style: TextStyle(fontSize: 13.sp),
          ),
        ),
      ),
    );
  }
}
