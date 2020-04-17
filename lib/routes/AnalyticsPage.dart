import 'dart:async';
import 'dart:collection';

enum IRouterState {
  /// 页面进入
  enter,

  /// 页面离开
  exit,
}

class IStreamData {
  /// 路由名称
  String name;

  /// 路由状态
  IRouterState state;

  /// 时间
  DateTime time;

  IStreamData({this.name, this.state, this.time});
}

class AnalyticsPage {
  bool _initFlag = false;
  IStreamData _lastRoute = IStreamData(); // 上一次路由
  LinkedHashMap<String, IStreamData> _routerStack = new LinkedHashMap();
  StreamController<IStreamData> _streamCtr = StreamController<IStreamData>();
  Stream streamPeriodic;

  /// 初始化
  init({
    /// 处理路由栈间隔时长
    int interval = 1000,
  }) {
    // if (_initFlag) return;
    print('点击了');
    _streamCtr.stream.listen((routeData) {
      _routerStack[routeData.name] = routeData;
    });
    streamPeriodic = Stream.periodic(Duration(milliseconds: interval), (index) {
      print("index------>$index");
    });
    streamPeriodic.listen((resData) {});
    _initFlag = true;
  }

  /// 埋点统计开始
  beginPageView(String name) async {
    _streamCtr.sink.add(IStreamData(
      name: name,
      state: IRouterState.enter,
      time: DateTime.now(),
    ));
  }

  /// 埋点统计结束
  endPageView(String name) async {
    _streamCtr.sink.add(IStreamData(
      name: name,
      state: IRouterState.exit,
      time: DateTime.now(),
    ));
  }

  /// 关闭终止流
  close() => _streamCtr.close();

  /// 暂停监听流,可被唤醒
  pause() => _streamCtr.onPause();

  /// 唤醒pause的流
  resume() => _streamCtr.onResume();
}
/* 
通过strem流管理整体,堆栈级别
每次进入循环队列中,进行B埋点开始记录,
如果之前已经开始计时A埋点,先找队列中是否有相同A名称的埋点结束起,循环一轮找不到情况下,把B埋点(开始)存入队列中,后续处理.
下次某C埋点开始记录,或有结束埋点记录,一样循环一次,先结束A埋点起,否则接着插入队列.

 */
