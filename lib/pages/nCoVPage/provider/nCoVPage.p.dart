import 'package:baixing/pages/nCoVPage/model/myCity_model.dart';
import 'package:baixing/pages/nCoVPage/model/ncvOverall_model.dart';
import 'package:baixing/services/service_method.dart';
import 'package:baixing/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';

class NCoVPageStore extends ChangeNotifier {
  List<Map<String, String>> ncvOverallData = [
    {
      'title': '确诊',
      'count': '0',
      'oldDayCount': '0',
      'color': '0xFFC74205',
    },
    {
      'title': '疑似',
      'count': '0',
      'oldDayCount': '0',
      'color': '0xFFE57F00',
    },
    {
      'title': '重症',
      'count': '0',
      'oldDayCount': '0',
      'color': '0xFF17A2B8',
    },
    {
      'title': '死亡',
      'count': '0',
      'oldDayCount': '0',
      'color': '0xFF616161',
    },
    {
      'title': '治愈',
      'count': '0',
      'oldDayCount': '0',
      'color': '0xFF009462',
    },
  ];
  String newUpTime; // 最新数据时间
  String newDay = '1.2'; // 当前日期时间
  String oldDay = '1.1'; // 昨天日期时间
  bool loadFlag = true;
  MyCityResults myCityResults; // 当前城市数据

  /// 获取全国疫情数据
  Future initNcvOverall() async {
    loadFlag = true;
    try {
      NcvOverallModel res = await getNcvOverall();
      Results resultsData = res?.results[0] ?? null;
      if (resultsData != null) {
        // 时间日期格式处理
        int _updateTime = resultsData.updateTime;
        newUpTime = DateUtils.formatDateStr(
            _updateTime, [yyyy, '.', m, '.', dd, ' ', HH, ':', nn]);
        newDay = DateUtils.formatDateStr(_updateTime, [m, '.', dd]);
        DateTime oldTimeStr = DateTime.fromMillisecondsSinceEpoch(_updateTime)
            .add(Duration(days: -1));
        oldDay = DateUtils.formatDateStr(
            oldTimeStr.millisecondsSinceEpoch, [m, '.', dd]);

        // 确诊
        ncvOverallData[0]['count'] = resultsData.confirmedCount.toString();
        ncvOverallData[0]['oldDayCount'] = resultsData.confirmedIncr.toString();
        // 疑似
        ncvOverallData[1]['count'] = resultsData.suspectedCount.toString();
        ncvOverallData[1]['oldDayCount'] = resultsData.suspectedIncr.toString();
        // 重症
        ncvOverallData[2]['count'] = resultsData.seriousCount.toString();
        ncvOverallData[2]['oldDayCount'] = resultsData.seriousIncr.toString();
        // 死亡
        ncvOverallData[3]['count'] = resultsData.deadCount.toString();
        ncvOverallData[3]['oldDayCount'] = resultsData.deadIncr.toString();
        // 治愈
        ncvOverallData[4]['count'] = resultsData.curedCount.toString();
        ncvOverallData[4]['oldDayCount'] = resultsData.curedIncr.toString();
      }
    } catch (e) {}
    loadFlag = false;
    notifyListeners();
  }

  /// 获取自己城市数据信息
  getMyCityData(String myCityName) async {
    try {
      MyCityModel resData = await getArea(city: myCityName ?? '湖北省');
      print('2434>>>${resData.results[0]}');
      myCityResults = resData.results[0] ?? null;
    } catch (e) {}
    notifyListeners();
  }
}
