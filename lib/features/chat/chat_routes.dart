import 'package:mad_navigator/mad_navigator.dart';

import 'chat.dart';

class ChatRoutes {
  static const String chat = 'chat/';

  static List<MadPage> routes = <MadPage>[
    MadPage(
        name: ChatRoutes.chat,
        pageBuilder: ({MadPageParams? params}) {
          assert(params?.arguments != null);
          return ChatPage(
            arguments: params!.arguments! as ChatPageArguments,
          );
        }),
  ];
}
