import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../provider/goodsDetailsInfo_stroe.dart';

class DetailsWeb extends StatefulWidget {
  @override
  _DetailsWebState createState() => _DetailsWebState();
}

class _DetailsWebState extends State<DetailsWeb> {
  WebViewController webViewController;
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsDetailsInfoStore>(
      builder: (_, store, child) {
        String htmlDetailsData = store.goodsInfo['goodsDetail']; // 获取web代码，详情
        final String contentBase64 = Uri.dataFromString(
          htmlDetailsData, // 字符串
          mimeType: 'text/html', // 转成网页格式文本
          encoding: Encoding.getByName('utf-8'), // 转换utf-8
        ).toString();

        if (store.selectTab == 0) {
          return Container(
            padding: EdgeInsets.only(bottom: 100, left: 10, right: 10),
            constraints: BoxConstraints(minHeight: 120, maxHeight: 2200),
            child: WebView(
              initialUrl: 'data:text/html;$contentBase64',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                webViewController = webViewController;
              },
            ),
          );
        }

        // 评论显示内容
        return Container(
          margin: EdgeInsets.only(bottom: 300),
          alignment: Alignment.center,
          child: Text('暂无评论内容...'),
        );
      },
    );
  }
}
