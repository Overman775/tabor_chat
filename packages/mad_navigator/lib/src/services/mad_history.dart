part of 'mad_navigator.dart';

class MadHistory extends NavigatorObserver {
  final ValueNotifier<List<int>> _tabHistory = ValueNotifier<List<int>>(<int>[0]);
  final ValueNotifier<List<String>> _pageHistory = ValueNotifier<List<String>>(<String>[]);

  /// Service logger
  final void Function(Object object) _logger = madLogger;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _pageHistory.value.removeLast();
    _logger('Page => `${_pageHistory.value.last}`');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == null) {
      return;
    }
    _pageHistory.value.add(route.settings.name!);
    _logger('Page => `${_pageHistory.value.last}`');
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      throw UnimplementedError('!!! Bingo, this is a bonus level !!! Describe your case for deleting a page)');
    } else {
      _pageHistory.value.removeWhere((String _route) => _route == route.settings.name);
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute?.settings.name == null) {
      return;
    }
    final int index = _pageHistory.value.indexWhere((String _route) => _route == oldRoute?.settings.name);

    //TODO: optimize this sheet
    _pageHistory.value[index] = newRoute?.settings.name ?? '';
    _logger('Page => `${_pageHistory.value.last}`');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('didStartUserGesture');
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    debugPrint('didStopUserGesture');
    super.didStopUserGesture();
  }
}

/// History of tabs indexes and root
/// Root navigator writing like [int -1]
mixin MadTabHistory on MadHistory {
  UnmodifiableListView<int> get tabHistory => UnmodifiableListView<int>(_tabHistory.value);
  int get currentTab => _tabHistory.value.last;
  bool get isRootPage => _tabHistory.value.last < 0;

  void _addTabToHistory(int index) => _tabHistory.value.add(index);
  void _removeLastTabHistory() => _tabHistory.value.removeLast();
  // void _removeLastTabHistory() {
  //   if (_tabHistory.value.length > 1) {
  //     _tabHistory.value.removeLast();
  //   }
  // }
}

/// History of pages
mixin MadPageHistory on MadHistory {
  UnmodifiableListView<String> get pageHistory => UnmodifiableListView<String>(_pageHistory.value);

  bool pageEqual(String pageName) {
    if (_pageHistory.value.isNotEmpty == true) {
      return _pageHistory.value.last == pageName;
    }
    return false;
  }
}
