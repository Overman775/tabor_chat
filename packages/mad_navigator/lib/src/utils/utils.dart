import 'package:path_to_regexp/path_to_regexp.dart';

Map<String, dynamic> normalizeMap(Map<String, String> map) {
  final Map<String, dynamic> newMap = <String, dynamic>{};

  map.forEach((String key, String value) => newMap[key] = normalizeType(value));

  return newMap;
}

Map<String, String> stringifyMap(Map<String, dynamic> map) {
  final Map<String, String> newMap = <String, String>{};

  map.forEach((String key, dynamic value) => newMap[key] = value.toString());

  return newMap;
}

dynamic normalizeType(String value) {
  if (int.tryParse(value) != null) {
    return int.parse(value);
  }
  if (double.tryParse(value) != null) {
    return double.parse(value);
  }
  if (value.toLowerCase() == 'true') {
    return true;
  }
  if (value.toLowerCase() == 'false') {
    return false;
  }

  return value;
}

String preparePath(String path, Map<String, dynamic> params) {
  if (path.contains('/:')) {
    final PathFunction toPath = pathToFunction(path);

    if (params is Map<String, String>) {
      return toPath(params);
    } else {
      return toPath(stringifyMap(params));
    }
  } else {
    return path;
  }
}
