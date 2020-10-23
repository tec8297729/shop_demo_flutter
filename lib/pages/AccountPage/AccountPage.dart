import 'package:ana_page_loop/components/TabViewListenerMixin.dart';
import 'package:baixing/routes/routeName.dart';
import 'package:baixing/utils/util.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart' show Consumer;
import 'components/AccountListItem.dart';
import 'components/AvatarWidget.dart';
import 'components/BirthdayWidget.dart';
import 'provider/accountPage.p.dart';

/// 帐号资料
class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with
        AutomaticKeepAliveClientMixin,
        SingleTickerProviderStateMixin,
        TabViewListenerMixin {
  @override
  bool get wantKeepAlive => true;

  String uuid = '108623512';
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  TabViewMixinData initPageViewListener() {
    return TabViewMixinData(
      tabsData: ['转转', '头条', '热点', '趣事'],
      controller: _tabController,
    );
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void didPop() {
    super.didPop();
  }

  @override
  void didPush() {
    super.didPush();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('帐号资料'),
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AvatarWidget(), // 用户头像item
            AccountListItem(
              title: 'UUID',
              trailing: Text(uuid),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: uuid));
                Util.toastTips('UUID号已复制到粘贴板');
              },
            ),
            birthItemWidget(),
            logoutItem(),
            // ...testTabWidget(),
          ],
        ),
      ),
    );
  }

  /// 测试组件
  List<Widget> testTabWidget() {
    return [
      Container(
        width: 300,
        height: 100,
        child: TabBar(
          controller: _tabController, // 动画状态定义
          // 选项卡显示的组件
          tabs: <Widget>[
            Icon(Icons.new_releases),
            Icon(Icons.picture_as_pdf),
            Tab(
              icon: Icon(Icons.accessible_forward),
              child: Container(child: Text('text')),
            )
          ],
          // tab标签页点击事件
          onTap: (int index) {},
        ),
      ),
      Container(
        width: 300,
        height: 100,
        child: TabBarView(
          controller: _tabController,
          // 里面定义不同tab显示的内容
          children: [
            Container(
              color: Colors.lightBlue,
            ),
            Container(
              color: Colors.greenAccent,
            ),
            Container(
              color: Colors.deepPurple,
            ),
          ],
        ),
      ),
    ];
  }

  /// 生日组件item
  birthItemWidget() {
    return AccountListItem(
      title: '出生年月日',
      trailing: Consumer<AccountPageStore>(
        builder: (context, store, __) {
          String _formatMydate = '';
          if (store.selectDate != null) {
            _formatMydate =
                formatDate(store.selectDate, [yyyy, '-', mm, '-', dd]);
          }
          return Text(_formatMydate);
        },
      ),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return BirthdayWidget();
          },
        );
      },
    );
  }

  /// 注销登出
  Widget logoutItem() {
    return AccountListItem(
      title: '注销登出',
      onTap: () async {
        Navigator.pushNamed(context, RouteName.loginPage);
      },
    );
  }
}
