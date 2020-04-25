import 'package:flutter/material.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import './components/RightDrawer.dart';
import './components/WebView.dart';
import './components/OrderType.dart';
import './components/H5View.dart';
import 'components/ActionList.dart';
import 'components/TopHeader.dart';

class Member extends StatefulWidget {
  Member({Key key, this.params}) : super(key: key);
  final params;

  @override
  _MemberState createState() => _MemberState();
}

enum Movies { CaptainMarvel, Shazm }

class _MemberState extends State<Member> with AutomaticKeepAliveClientMixin {
  String title = '会员中心';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          TopHeader(), // 顶部头像区域
          orderTitle(), // 我的订单区域
          OrderType(), // 横向菜单列表
          ActionList(),
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
                  return WebView(url: 'https://www.jonhuu.com');
                },
              ));
        },
      ),
    );
  }
}
