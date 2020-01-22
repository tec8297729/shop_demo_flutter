import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './components/RightDrawer.dart';
import './components/WebView.dart';
import './components/OrderType.dart';
import './components/H5View.dart';
import 'components/ActionList.dart';

class Member extends StatefulWidget {
  Member({Key key, this.params}) : super(key: key);
  final params;

  @override
  _MemberState createState() => _MemberState();
}

enum Movies { CaptainMarvel, Shazm }

class _MemberState extends State<Member> {
  String title = '会员中心';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
        // 顶部右侧菜单
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),

      endDrawer: RightDrawer(), // 右侧抽屉
      body: ListView(
        children: <Widget>[
          topHeader(), // 顶部区域
          orderTitle(), // 我的订单区域
          OrderType(), // 横向菜单列表
          ActionList(),
        ],
      ),
    );
  }

  // 头部区域，头像
  Widget topHeader() {
    return Container(
      height: ScreenUtil().setHeight(400),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.lightBlue.withOpacity(0.3),
            Colors.purple.withOpacity(0.3),
            Color(0xFFE2B0FF).withOpacity(0.3),
            Color(0xFF9F44D3).withOpacity(.5),
          ],
          radius: 0.2, // 渐变的半径，具体数值需要乘以盒子的宽度
          tileMode: TileMode.repeated, // 平铺模式
          stops: [0.3, 0.5, 0.6, 1], // 颜色的分割比例，数值是递增的，值0-1之间的
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            height: ScreenUtil().setHeight(180),
            child: ClipOval(
              // child: CachedNetworkImage(
              //   imageUrl:
              //       'https://i.keaitupian.net/up/fe/98/d9/884ada56623a11f6a0f38ab29fd998fe.jpg',
              //   fit: BoxFit.cover,
              //   // 动画组件，需要回传一个weiget组件
              //   placeholder: (context, url) => new CircularProgressIndicator(),
              //   // 图片读取失败显示的weiget组件
              //   errorWidget: (context, url, error) => new Icon(Icons.error),
              // ),
              child: Image(
                image: AdvancedNetworkImage(
                  'https://i.keaitupian.net/up/fe/98/d9/884ada56623a11f6a0f38ab29fd998fe.jpg',
                  useDiskCache: true,
                  cacheRule: CacheRule(maxAge: const Duration(days: 30)),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '未知的小强',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 我的博客H5组件
  Widget orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的博客h5'),
        trailing: Icon(Icons.arrow_right),
        // 标题组件整体点击事件
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            // return H5View();
            return WebView(
              url: 'https://www.jonhuu.com',
            );
          }));
        },
      ),
    );
  }
}
