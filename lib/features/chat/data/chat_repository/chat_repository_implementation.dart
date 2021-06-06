import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../chat.dart';
import 'chat_repository.dart';

@prod
@Injectable(as: ChatRepository)
class ChatRepositoryImplementation implements ChatRepository {
  ChatRepositoryImplementation({required this.network});

  final NetworkService network;

  @override
  Future<List<RoomMessage>> loadHistory(String roomName) async {
    final String uriRoomName = Uri.encodeFull(roomName);

    final Map<String, dynamic>? result = await network.get<Map<String, dynamic>>('/rooms/$uriRoomName/history');

    if (result?['result'] != null) {
      return (result!['result'] as List<dynamic>)
          .map((dynamic e) => RoomMessage.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw 'History not loaded';
    }
  }
}
