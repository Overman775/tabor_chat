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
    return BlocProvider<RoomsBloc>(
        create: (_) => RoomsBloc(
              navigator: injector.get(),
              repository: injector.get(),
            )..add(GetRoomsEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.rooms_title.tr()),
          ),
          floatingActionButton: const AddChat(),
          body: const _Content(),
        ));
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsBloc, RoomsState>(
      builder: (BuildContext context, RoomsState state) {
        if (state is RoomsLoadingState) {
          return const _Rooms();
        } else if (state is RoomsLoadedState) {
          return _RoomsList(rooms: state.rooms);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _Rooms extends StatelessWidget {
  const _Rooms({Key? key}) : super(key: key);

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
    final EdgeInsetsGeometry paddingSafeArea = MediaQuery.of(context).padding;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: rooms.length,
      padding: paddingSafeArea,
      itemBuilder: (BuildContext context, int index) {
        return RoomTile(
          key: Key('Room_${rooms[index].name}'),
          room: rooms[index],
        );
      },
    );
  }
}
