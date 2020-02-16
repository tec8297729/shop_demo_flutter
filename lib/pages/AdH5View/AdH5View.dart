import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdH5View extends StatefulWidget {
  AdH5View({this.params});
  final params;
  @override
  _AdH5ViewState createState() => _AdH5ViewState();
}

class _AdH5ViewState extends State<AdH5View> {
  WebViewController _webController;
  String title = '网页浏览';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: WebView(
        initialUrl: widget.params['url'], // 初始加载页面url
        //JS执行模式 unrestricted不限制使用js，disabled禁用js脚本
        javascriptMode: JavascriptMode.unrestricted,
        // webview 创建时调用此函数
        onWebViewCreated: (WebViewController web) {
          _webController = web;
        },
        gestureRecognizers: Set()
          ..add(
            Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer()),
          ),

        debuggingEnabled: true,
        // 页面路由拦截器
        navigationDelegate: (NavigationRequest request) {
          // 处理H5点击导航事件，比如返回操作，跳转页面等
          // prevent阻止导航事件，navigate允许导航
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
