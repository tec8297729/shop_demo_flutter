import 'package:baixing/config/app_config.dart';

class LogUtil {
  static d(String data) {
    if (AppConfig.printFlag) {
      print(data);
    }
  }
}
