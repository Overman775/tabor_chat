import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../rooms.dart';
import 'rooms_repository.dart';

@prod
@Injectable(as: RoomsRepository)
class RoomsRepositoryImplementation implements RoomsRepository {
  RoomsRepositoryImplementation({required this.network});

  final NetworkService network;

  @override
  Future<List<Room>> loadRooms() async {
    final Map<String, dynamic>? result = await network.get<Map<String, dynamic>>('/rooms');

    if (result?['result'] != null) {
      return (result!['result'] as List<Map<String, dynamic>>)
          .map((Map<String, dynamic> e) => Room.fromJson(e))
          .toList();
    } else {
      throw 'Rooms not loaded';
    }
  }
}
