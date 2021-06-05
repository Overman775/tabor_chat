import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

import '../interfaces/mad_navigator_interface.dart';
import '../models/mad_page.dart';
import '../models/mad_page_params.dart';
import '../models/mad_tab.dart';
import '../transition/router_page_transition.dart';
import '../utils/logger.dart';

part 'mad_history.dart';

abstract class MadNavigatorService extends MadHistory
    with MadPageHistory, MadTabHistory
    implements MadNavigatorInterface {
  MadNavigatorService({this.closeAppOnPop = false}) {
    tabController.addListener(() => _addHistory(tabController.index));
    MadNavigatorService.instance = this;
  }

  static late MadNavigatorService instance;

  /// Controller for tabs
  final CupertinoTabController tabController = CupertinoTabController();

  /// Close app when [_tabHistory] ended.
  final bool closeAppOnPop;

  NavigatorState get currentNavigatorState {
    if (isRootPage) {
      return homeRouter.navigatorKey.currentState!;
    } else {
      return routerTabs[currentTab].navigatorKey.currentState!;
    }
  }

  void _addHistory(int index) {
    // skep add to _history when return on pop
    if (currentTab != index) {
      _addTabToHistory(index);

      if (index >= 0) {
        _logger('Tab => ${routerTabs[index].toStringShort()}');
      } else {
        _logger('Root');
      }
    }
  }

  Future<void> changeTab(int tabIndex) async {
    if (tabIndex != currentTab) {
      tabController.index = tabIndex;
      //Wait when tab changed
      if (!isRootPage && routerTabs[currentTab].navigatorKey.currentState == null) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 200));
      }
    }
  }

  Future<void> _tabHistoryBack() async {
    if (_tabHistory.value.length > 1) {
      final Completer<void> completer = Completer<void>();

      _removeLastTabHistory();

      tabController.index = currentTab;
      //Wait when tab changed
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        completer.complete();
        _logger('Tab => ${routerTabs[currentTab].toStringShort()}');
      });
      return completer.future;
    }
  }

  Future<void> _historyBack() async {
    if (_tabHistory.value.length > 1) {
      _removeLastTabHistory();
    }
  }

  Future<void> go(String name, {Object? arguments, RoutePredicate? removeUntil}) async {
    // Search in root router
    final MadPage? page = homeRouter.searchPage(name);

    //Open page in root
    if (page != null) {
      final MadPageParams pageParams = MadPageParams(arguments: arguments, params: page.parsePath(name));
      _addHistory(-1);
      _logger('Page => `${page.toString()}`');
      await _push(homeRouter.navigatorKey.currentState, page.name, removeUntil, pageParams);
    }
    //Check tabs
    else {
      // Search in tabs routers
      final String firstPath = name.split('/').first;
      final MadTab? tab = routerTabs.firstWhereOrNull((MadTab e) => e.name == firstPath);

      if (tab != null) {
        final MadPage? pageTab = tab.searchPage(name.substring(name.indexOf('/') + 1));

        //Open page in tab
        if (pageTab != null) {
          await changeTab(routerTabs.indexOf(tab));

          final MadPageParams pageParams = MadPageParams(arguments: arguments, params: pageTab.parsePath(name));
          _logger('Page => `${pageTab.toString()}`');
          await _push(tab.navigatorKey.currentState, pageTab.name, removeUntil, pageParams);
        }
        //Open unknown page in tab
        else {
          await changeTab(routerTabs.indexOf(tab));
          await _pushUnknownRoute(tab.navigatorKey.currentState);
        }
      }
      //Open unknown page in root
      else {
        // if (!isRootPage) {
        //   _addHistory(-1);
        // }
        _addHistory(-1);
        await _pushUnknownRoute(homeRouter.navigatorKey.currentState);
        //TODO: fix this peace of sheet
        // await _pushUnknownRoute(homeRouter.navigatorKey.currentState);
      }
    }
  }

  Future<void> _push(
      NavigatorState? navigator, String name, RoutePredicate? removeUntil, MadPageParams pageParams) async {
    if (removeUntil != null) {
      await navigator?.pushNamedAndRemoveUntil(name, removeUntil, arguments: pageParams);
    } else {
      await navigator?.pushNamed(name, arguments: pageParams);
    }
  }

  Future<void> _pushUnknownRoute(NavigatorState? navigator) async {
    _logger('Page => `Unknown`');
    await navigator?.push<dynamic>(routeBuilder(unknownPage));
  }

  void pop() => currentNavigatorState.pop();

  bool canPop() => currentNavigatorState.canPop();

  Future<bool> onWillPop() async {
    if (canPop() == true) {
      pop();
      _historyBack();

      return false;
    } else {
      if (!isRootPage) {
        _tabHistoryBack();
        return false;
      } else {
        _historyBack();
        return closeAppOnPop;
      }
    }
  }

  void dispose() {
    tabController.dispose();
  }
}
