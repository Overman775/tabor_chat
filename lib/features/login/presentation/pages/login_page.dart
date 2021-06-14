import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../common/common.dart';
import '../../../initialization/models/initialized_settings.dart';
import '../../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(
          navigator: injector.get(),
          socketService: injector.get(),
          socketUrl: injector.get(instanceName: 'socketUrl'),
        ),
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  late GlobalKey<FormState> _formKey;
  late InitializedSettings _settings;
  late TextEditingController _nameTextController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _settings = injector.get();
    _nameTextController = TextEditingController();
    super.initState();
  }

  void _onPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(LoginAuthorizeEvent(name: _nameTextController.text));
    }
  }

  String? _nameValidator(String? text) {
    if (text == null || text.trim().length < 3) {
      return LocaleKeys.login_errors_min_length_name.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Spacer(),
            SizedBox(
              width: 250.sp,
              child: TextFormField(
                controller: _nameTextController,
                decoration: InputDecoration(labelText: LocaleKeys.login_label_login.tr()),
                validator: _nameValidator,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(_settings.maxUsernameLength),
                ],
                onEditingComplete: _onPressed,
              ),
            ),
            SizedBox(height: Ds.defaultMargin.sp),
            _LoginButton(onPressed: _onPressed),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.sp,
      height: 40.sp,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          if (state is LoginSendingState) {
            return const ElevatedButton(
              onPressed: null,
              child: DefaultPreloader(),
            );
          }
          return ElevatedButton(
            onPressed: onPressed,
            child: Text(LocaleKeys.login_enter_button.tr()),
          );
        },
      ),
    );
  }
}
