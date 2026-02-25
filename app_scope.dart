import 'package:flutter/material.dart';

import '../services/token_storage.dart';
import '../l10n/locale_controller.dart';

class AppScope extends InheritedWidget {
  final LocaleController locale;
  final TokenStorage tokenStorage;

  const AppScope({
    super.key,
    required this.locale,
    required this.tokenStorage,
    required super.child,
  });

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      oldWidget.locale != locale || oldWidget.tokenStorage != tokenStorage;
}
