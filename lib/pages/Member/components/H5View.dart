import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class H5View extends StatefulWidget {
  @override
  _H5ViewState createState() => _H5ViewState();
}

class _H5ViewState extends State<H5View> {
  WebViewController _webController;
  String title = '个人博客';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: WebView(
        initialUrl: "https://www.jonhuu.com/", // 初始加载页面url
        //JS执行模式 unrestricted不限制使用js，disabled禁用js脚本
        javascriptMode: JavascriptMode.unrestricted,
        // webview 创建时调用此函数
        onWebViewCreated: (WebViewController web) {
          _webController = web;
        },
        onPageStarted: (String value) {
          // 获取web端标题
          _webController.evaluateJavascript("document.title").then((result) {
            print(result);
            // 设置标题到APP上
            setState(() {
              title = result;
            });
          });
        },
        gestureRecognizers: Set()
          ..add(
            Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer()),
          ),

        debuggingEnabled: true,
        // 当页面完成加载时调用,页面还没渲染时
        onPageFinished: (String url) {},
        // 页面路由拦截器
        navigationDelegate: (NavigationRequest request) {
          print(request.url);
          if (request.url.indexOf('m=webview') > -1) {
            String _url = request.url.replaceAll('&m=webview', ''); // 过滤些一些参数

          }
          // return NavigationDecision.prevent;
          // 处理H5点击导航事件，比如返回操作，跳转页面等
          // prevent阻止导航事件，navigate允许导航
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
