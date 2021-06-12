import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../common/common.dart';
import '../../initialization.dart';

class InitializationPage extends StatelessWidget {
  const InitializationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<InitializationBloc>(
        create: (_) => InitializationBloc(
          navigator: injector.get(),
          repository: injector.get(),
        )..add(const InitializationStartEvent()),
        child: const _Preloader(),
      ),
    );
  }
}

class _Preloader extends StatelessWidget {
  const _Preloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitializationBloc, InitializationState>(
      builder: (BuildContext context, InitializationState state) {
        return const Center(
          child: DefaultPreloader(),
        );
      },
    );
  }
}
