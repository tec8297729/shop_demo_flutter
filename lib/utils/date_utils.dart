import 'package:date_format/date_format.dart';

export 'package:date_format/date_format.dart'
    show yyyy, yy, mm, m, MM, dd, D, DD, hh, HH, n, nn, s, ss, z;

/// 日期转换方法
class DateUtils {
  /// 时间戳转换成指定格式，返回字符串
  /// [format] 指定转换格式, 默认输出 yyyy年mm月dd日 hh小时 nn分钟 ss秒 z
  static String formatDateStr(int milliseconds, [List<String> format]) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    format = format ?? [yyyy, '-', mm, '-', dd, '时', HH, ':', nn, ':', ss, z];
    return formatDate(dateTime, format);
  }
}
