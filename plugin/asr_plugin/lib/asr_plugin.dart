import 'package:flutter/services.dart';

class AsrManager {
  // 与指定原生插件通信，一次性通信
  static const MethodChannel _channel = const MethodChannel('asr_plugin');

  /// 开始录音
  static Future<String> star({Map params}) async {
    // 调用native端的start方法，传入参数给native使用
    return await _channel.invokeMethod('start', params ?? {});
  }

  /// 停止录音
  static Future<String> stop({Map params}) async {
    return await _channel.invokeMethod('stop');
  }

  /// 取消录音
  static Future<String> cancel({Map params}) async {
    return await _channel.invokeMethod('cancel');
  }
}
