import 'package:baixing/config/app_config.dart';

class LogUtil {
  static p(Object data) {
    if (AppConfig.printFlag) {
      print(data);
    }
  }
}
