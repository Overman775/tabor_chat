class ChatPageArguments {
  const ChatPageArguments({
    required this.roomName,
    this.isNewChat = false,
  });

  final String roomName;
  final bool isNewChat;
}
