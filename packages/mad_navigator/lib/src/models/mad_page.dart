import 'package:flutter/widgets.dart';
import 'package:path_to_regexp/path_to_regexp.dart' as parser;

import '../utils/utils.dart';
import 'mad_page_params.dart';
import 'mad_transition_settings.dart';

class MadPage {
  MadPage({
    required this.name,
    required this.pageBuilder,
    this.transitionSettings = const MadTransitionSettings(),
  }) {
    isDynamic = name.contains(':/');
    pathRegExp = parser.pathToRegExp(name, parameters: dynamicParams);
  }

  final String name;
  final PageBuilder pageBuilder;
  final MadTransitionSettings transitionSettings;
  late bool isDynamic;

  late RegExp pathRegExp;
  List<String> dynamicParams = <String>[];

  Map<String, dynamic>? parsePath(String path) {
    final Match? match = pathRegExp.matchAsPrefix(path);
    if (match != null) {
      final Map<String, String> params = parser.extract(dynamicParams, match);
      return normalizeMap(params);
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return 'MadPage(name: $name, pageBuilder: $pageBuilder,  transitionSettings: $transitionSettings)';
  }
}

typedef PageBuilder = Widget Function({MadPageParams? params});
