import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 拨打电话页面组件
class LeaderPhone extends StatelessWidget {
  final String leaderImg; // 图片
  final String phone; // 电话
  LeaderPhone({Key key, @required this.leaderImg, @required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _handleUrl,
        child: Image.network(leaderImg),
      ),
    );
  }

  void _handleUrl() async {
    String url = 'tel:$phone';
    // 判断能否打电话
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'error: url不能进行访问';
    }
  }
}
