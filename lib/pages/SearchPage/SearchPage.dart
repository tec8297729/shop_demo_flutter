import 'dart:async';

import 'package:baixing/components/SearchBar/SearchBar.dart';
import 'package:baixing/model/search_model.dart';
import 'package:baixing/pages/SearchPage/components/TabsWrap.dart';
import 'package:flutter/material.dart';
import 'package:baixing/service/service_method.dart';
import 'package:jh_debug/jh_debug.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';
  bool _showDialog = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: '哈哈',
            hint: '123',
            onChanged: _onTextChange,
            rightButtonClick: _onSearchFn,
            speakClick: () {
              jhDebug.showLog();
            },
          ),

          // GestureDetector(
          //   onTap: () {},
          // ),
          Text(showText),
        ],
      ),
    );
  }

  // 输入框事件回调
  _onTextChange(text) {}

  // 搜索事件
  _onSearchFn() async {
    // SearchModel data = await getSearchCtrip('长城');
    print('>>>>>测试');
    throw "Sample for exception";
    // Future.error("error>>> 333");
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     // 返回你要显示的组件内容
    //     return Dialog(
    //       child: TabsWrap(),
    //     );
    //   },
    // );
  }
}
