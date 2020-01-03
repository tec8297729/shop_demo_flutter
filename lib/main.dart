import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/onGenerateRoute.dart';
import 'routes/routesInit.dart'; // 路由配置
import 'model/themeStore/themeStore.dart'; // 全局主题
import 'providers_config.dart';

void main() {
  runApp(MultiProvider(
    providers: providersConfig,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStore>(
      builder: (_, themeStore, child) {
        return MaterialApp(
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
