import 'package:ana_page_loop/ana_page_loop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:provider/provider.dart';
import 'ioc/locator.dart' show setupLocator, locator, CommonService;
import 'routes/onGenerateRoute.dart';
import 'routes/routesData.dart'; // 路由配置
import 'provider/themeStore.dart'; // 全局主题
import 'providers_config.dart';
import 'utils/myAppInit/index.dart' show myyAppInit;

void main() {
  setupLocator();

  jhDebugMain(
    appChild: MultiProvider(
      providers: providersConfig,
      child: MyApp(),
    ),
    debugMode: DebugMode.inConsole,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    jhDebug.setGlobalKey = locator.get<CommonService>().getGlobalKey;
    myyAppInit();

    return Consumer<ThemeStore>(
      builder: (_, themeStore, child) {
        return MaterialApp(
          locale: Locale('zh', 'CH'),
          navigatorKey: jhDebug.getNavigatorKey,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('zh', 'CH'),
            const Locale('en', 'US'), // English
          ],
          theme: themeStore.getTheme,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            // AnalyticsObserver(),
            // routeObserver,
            ...anaAllObs(),
          ],
        );
      },
    );
  }
}
