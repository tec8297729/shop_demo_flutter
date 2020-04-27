import 'package:baixing/build/ff_route.dart';
import 'package:flutter/material.dart';


@FFRoute(name: 'errorAA')
// 错误页面
class ErrorPage extends StatefulWidget {
  ErrorPage({Key key, this.params}) : super(key: key);
  final params;

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ErrorPage'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(
              Icons.error, // 图标
              color: Colors.red, // 颜色
              size: 66, // 大小
            ),
          ),
          Text(
            '错误：未定义的路由',
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
