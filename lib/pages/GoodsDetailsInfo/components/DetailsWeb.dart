import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../store/goodsDetailsInfo_stroe.dart';

class DetailsWeb extends StatefulWidget {
  @override
  _DetailsWebState createState() => _DetailsWebState();
}

class _DetailsWebState extends State<DetailsWeb> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsDetailsInfoStore>(
      builder: (_, store, child) {
        var detailsData = store.goodsInfo['goodsDetail']; // 获取web代码，详情
        if (store.selectTab == 0)
          return Container(
            padding: EdgeInsets.only(bottom: 100),
            child: Html(
              padding: EdgeInsets.all(8.0), // 边距
              backgroundColor: Colors.white70, // 背景颜色
              defaultTextStyle: TextStyle(fontFamily: 'serif'), // 默认文字样式
              // 超链接文字样式
              linkStyle: const TextStyle(
                color: Colors.redAccent,
              ),
              data: detailsData, // 纯字符串的html，会自动识别渲染出来
              // 点击图片时事件，返回图片url
              onImageTap: (String url) {
                print(url);
              },
              // 点击超链接时事件，返回Url
              onLinkTap: (String src) {},
            ),
          );

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
