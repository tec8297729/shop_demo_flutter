import 'dart:async';
import 'package:baixing/MainGlobalWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:provider/provider.dart';
import 'routes/onGenerateRoute.dart';
import 'routes/routesInit.dart'; // 路由配置
import 'store/themeStore/themeStore.dart'; // 全局主题
import 'providers_config.dart';

void main() {
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
    return Consumer<ThemeStore>(
      builder: (_, themeStore, child) {
        return MaterialApp(
          navigatorKey: jhDebug.getNavigatorKey,
          // locale: Locale('en', 'US'),
          locale: Locale('zh', 'CH'),
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
          // 全局统一获取路由传递的参数
          onGenerateRoute: onGenerateRoute,
          debugShowCheckedModeBanner: false,
          // navigatorObservers: [],
        );
      },
    );
  }
}
