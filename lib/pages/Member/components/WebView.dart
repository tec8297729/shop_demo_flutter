import 'dart:async';

import 'package:baixing/components/PageLoding/PageLoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  WebView({
    this.url,
    this.statusBarColor,
    this.backForbid,
  });

  /// h5页面访问的地址
  final String url;
  final String statusBarColor;
  final bool backForbid;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = new FlutterWebviewPlugin(); // 创建webview实例对象
  StreamSubscription<String> _onUrlChang;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool isErrorWidget = false; // 是否显示错误页面组件
  bool isBackIcon = false; // 是否显示回退图标，false为X图标
  String _appBarTitle = 'H5页面加载中...';

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    // 监听页面url变化的时候
    _onUrlChang = webviewReference.onUrlChanged.listen((String url) {});

    _onStateChanged = webviewReference.onStateChanged.listen(onStateListenFn);

    // 监听页面错误的时候
    _onHttpError = webviewReference.onHttpError.listen(
      (WebViewHttpError error) {
        print('H5页面状态码>>${error.code}');
        if (error.code == '-6' || error.code == '500') {
          setState(() {
            isErrorWidget = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _onUrlChang.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  // 监听页面变化时，执行的函数
  void onStateListenFn(WebViewStateChanged webState) async {
    switch (webState.type) {
      case WebViewState.startLoad: // 开始加载的时候
        print(webState.url);
        bool canGoBack = await webviewReference.canGoBack();
        setState(() {
          isBackIcon = canGoBack;
        });
        break;
      case WebViewState.finishLoad: // 页面加载完成时
        // 获取H5标题
        webviewReference.evalJavascript('document.title').then((value) {
          // print(value);
          String title = value?.replaceAll('"', '');
          if (title.length <= 0) title = '服务器正忙...';

          setState(() {
            _appBarTitle = title;
          });
        });
        break;
      default:
        break;
    }
  }

  // 回退按钮处理，默认优先回退页面，顶级页面后在回退APP
  handleWebGoBack() async {
    bool canGoBack = await webviewReference.canGoBack();

    // 判断H5页面是否可以回退操作
    if (canGoBack) {
      await webviewReference.goBack(); // 回退h5页面
    } else {
      Navigator.pop(context); // 回退APP
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        leading: IconButton(
          icon: Icon(isBackIcon ? Icons.arrow_back : Icons.close),
          padding: EdgeInsets.all(0),
          onPressed: handleWebGoBack, // 点击事件
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          handleWebView(),
        ],
      ),
    );
  }

  // H5组件页面
  handleWebView() {
    if (isErrorWidget) {
      return errorWebViewWidget();
    }
    return Expanded(
      child: WebviewScaffold(
        url: widget.url,
        withZoom: true, // 是否可以缩放
        withLocalStorage: true, // 是否本地储存
        hidden: true, // 默认是否隐藏

        // 在未页面加载页面之前显示的组件（等待页面）
        initialChild: PageLoading(),
      ),
    );
  }

  // 页面访问错误时显示的组件
  Widget errorWebViewWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Icon(
            Icons.error, // 图标
            color: Colors.red, // 颜色
            size: 66, // 大小
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(33)),
        Text(
          '服务器正忙...请稍后尝试！',
          style: TextStyle(fontSize: ScreenUtil().setSp(42)),
        ),
      ],
    );
  }
}
