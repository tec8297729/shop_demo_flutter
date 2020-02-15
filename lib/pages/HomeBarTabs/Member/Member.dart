import 'package:baixing/components/NumAnimation/NumAnimation.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import './components/RightDrawer.dart';
import './components/WebView.dart';
import './components/OrderType.dart';
import './components/H5View.dart';
import 'components/ActionList.dart';
import 'package:shimmer/shimmer.dart';

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
                print('广告');
                FlutterUmplus.event('233', label: '广告');
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
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue.withOpacity(0.3),
            Colors.purple.withOpacity(0.3),
            Color(0xFFEFD98D).withOpacity(0.3),
            Color(0xFF9F44D3).withOpacity(.5),
          ],
          // tileMode: TileMode.clamp, // 平铺模式
          stops: [0.2, 0.4, 0.6, 1], // 颜色的分割比例
          transform: GradientRotation(111), // 旋转角度
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 头像
          Container(
            width: ScreenUtil().setWidth(180),
            height: ScreenUtil().setHeight(180),
            child: CircleAvatar(
              foregroundColor: Colors.cyan,
              radius: 30, // 圆的直径
              backgroundColor: Colors.transparent, // 背景颜色
              backgroundImage: ImageUtils.getNetWorkImage(
                  'https://i.keaitupian.net/up/fe/98/d9/884ada56623a11f6a0f38ab29fd998fe.jpg'),
            ),
          ),

          // 文字区域
          Shimmer.fromColors(
            baseColor: Colors.black, // 背景底色
            highlightColor: Colors.white, // 高亮颜色
            period: Duration(milliseconds: 5000), // 动画时间
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, right: 5),
                  child: Text(
                    '未知的小强',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 22),
                  child: NumAnimation(value: 1000),
                ),
              ],
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
          Navigator.push(
              context,
              MaterialPageRoute(
                settings: RouteSettings(name: 'h5页面'),
                builder: (_) {
                  // return H5View();
                  return WebView(
                    url: 'https://www.jonhuu.com',
                  );
                },
              ));
        },
      ),
    );
  }
}
