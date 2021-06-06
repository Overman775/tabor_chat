import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../common/common.dart';
import '../../rooms.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.rooms_title.tr()),
      ),
      body: BlocProvider<RoomsLoaderBloc>(
        create: (_) => RoomsLoaderBloc(
          navigator: injector.get(),
          repository: injector.get(),
        )..add(GetRoomsLoaderEvent()),
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsLoaderBloc, RoomsLoaderState>(
      builder: (BuildContext context, RoomsLoaderState state) {
        if (state is RoomsLoadingState) {
          return const _RoomsLoader();
        } else if (state is RoomsLoadedState) {
          return _RoomsList(rooms: state.rooms);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _RoomsLoader extends StatelessWidget {
  const _RoomsLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: DefaultPreloader(),
    );
  }
}

class _RoomsList extends StatelessWidget {
  const _RoomsList({Key? key, required this.rooms}) : super(key: key);

  final List<Room> rooms;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: rooms.length,
      itemBuilder: (BuildContext context, int index) {
        return RoomTile(
          key: Key('Room_${rooms[index].name}'),
          room: rooms[index],
        );
      },
    );
  }
}
