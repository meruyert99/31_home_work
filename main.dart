import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'router/app_router.dart';
import 'services/token_storage.dart';
import 'l10n/locale_controller.dart';
import 'state/app_scope.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final locale = LocaleController();
  final tokenStorage = TokenStorage(const FlutterSecureStorage());
  final router = createRouter();

  runApp(MyApp(locale: locale, tokenStorage: tokenStorage, router: router));
}

class MyApp extends StatelessWidget {
  final LocaleController locale;
  final TokenStorage tokenStorage;
  final router;

  const MyApp({
    super.key,
    required this.locale,
    required this.tokenStorage,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return AppScope(
      locale: locale,
      tokenStorage: tokenStorage,
      child: ValueListenableBuilder<Locale>(
        valueListenable: locale,
        builder: (context, loc, _) {
          return MaterialApp.router(
            locale: loc,
            supportedLocales: const [Locale('en'), Locale('ru')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: router,
          );
        },
      ),
    );
  }
}
