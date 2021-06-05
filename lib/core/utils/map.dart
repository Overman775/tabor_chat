Map<T, List<R>> copyMap<T, R>(Map<T, List<R>> map) {
  final Map<T, List<R>> newMap = <T, List<R>>{};
  map.forEach((T key, List<R> value) {
    newMap[key] = List<R>.of(value);
  });
  return newMap;
}
