import 'package:flutter/cupertino.dart';

@immutable
class MadPageParams {
  const MadPageParams({
    this.arguments,
    this.params,
  });

  final Object? arguments;
  final Map<String, dynamic>? params;

  @override
  String toString() => 'MadPageParams(arguments: $arguments, params: $params)';
}
