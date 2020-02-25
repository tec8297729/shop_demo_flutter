import 'package:baixing/routes/routeName.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/search_model.dart';
import 'package:flutter/material.dart';
import '../../services/service_method.dart';
import '../../utils/util.dart' show Util;
import '../../components/SearchBar/SearchBar.dart';
import '../../constants/index_constants.dart';

class SearchPage extends StatefulWidget {
  /// 搜索关键字
  final String keyword;

  /// 默认搜索提示文字
  final String hint;

  final Map<String, String> params;

  const SearchPage({Key key, this.keyword, this.hint, this.params})
      : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel; // 搜索返回结果类型
  String keyword = '';

  @override
  void dispose() {
    super.dispose();
  }

  // 输入框事件回调
  _onTextChange(text) async {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    SearchModel data = await getSearchCtrip(text);
    setState(() {
      searchModel = data;
    });
  }

  // 搜索事件
  _onSearchFn() async {
    // SearchModel data = await getSearchCtrip('长城');
    // showAboutDialog(
    //   context: context,
    //   children: [Text('mwfdsfsdf')],
    //   useRootNavigator: false,
    // );
  }

  /// 获取本地图片路径
  String _typeImage(String type) {
    // String path = 'travelgroup';
    if (IMAGES_ICON_TYPES[type] ?? false) {
      return 'asset/images/type_$type.png';
    }
    return 'asset/images/type_travelgroup.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: <Widget>[
          _appBar(), // 顶部组件
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: searchModel?.data?.length,
              itemBuilder: (context, position) {
                return _searchWrapWidget(position);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// appBar组件处理
  Widget _appBar() {
    return Column(
      children: <Widget>[
        Container(
          // 定义宽高，离默认原生顶部栏下面
          padding: EdgeInsets.only(top: 20),
          height: ScreenUtil().setHeight(160),
          decoration: BoxDecoration(color: Colors.white),
          // 线性渐变
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [Color(0x66000000), Colors.transparent],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
          // ),
          child: SearchBar(
            // 是否隐藏左侧图标,容错处理
            hideLeft:
                widget?.params != null ? widget.params['hideLeft'] : false,
            defaultText: widget.keyword, // 输入框默认文字
            hint: widget.hint, // 默认提示文字,未输入文字时
            onChanged: Util.debounce(_onTextChange, 1000), // 防抖处理
            leftButtonClick: () => Navigator.pop(context),
            rightButtonClick: _onSearchFn,
            keyEnterFn: _onSearchFn,
            // 语音搜索事件
            speakClick: () {
              Navigator.pushNamed(context, RouteName.speakPage);
            },
          ),
        ),
      ],
    );
  }

  // 搜索结果wrap整体
  Widget _searchWrapWidget(int index) {
    if (searchModel == null || searchModel.data == null) return null;
    return _itemSearch(index);
  }

  // 结果展示item组件
  Widget _itemSearch(int index) {
    // 判断接口请求回来的数据
    if (searchModel == null) return null;
    SearchItem itemData = searchModel.data[index];
    return GestureDetector(
      // 点击事件
      onTap: () {
        // Navigator.push(
        //   context,
        //   RoutsAnimation(
        //     child: WebView(
        //       url: itemData.url,
        //       // title: '详情',
        //     ),
        //   ),
        // );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.3, color: Colors.grey),
          ),
        ),
        child: Row(
          children: <Widget>[
            // 左侧icon图标
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                height: ScreenUtil().setHeight(52),
                width: ScreenUtil().setWidth(52),
                image: AssetImage(_typeImage(itemData.type)),
              ),
            ),
            Column(
              children: <Widget>[
                // 标题，带城市位置
                Container(
                  width: ScreenUtil().setWidth(600),
                  child: _titleWidget(itemData),
                ),
                // 副标题文本
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: ScreenUtil().setWidth(600),
                  child: _subTitleWidget(itemData),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 富文本标题组件
  Widget _titleWidget(SearchItem itemData) {
    if (itemData == null) return null;
    List<TextSpan> spanList = [];
    // 标题区域关键字换色
    spanList.addAll(_keywordTextSpans(itemData.word, keyword));
    // 标题后缀内容
    spanList.add(
      TextSpan(
        text: ' ${itemData.districtname ?? ''} ${itemData.zonename ?? ''}',
        style: TextStyle(fontSize: ScreenUtil().setSp(32)),
      ),
    );

    return RichText(text: TextSpan(children: spanList));
  }

  _subTitleWidget(SearchItem itemData) {
    print(itemData.zonename);
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: '实时计价:${itemData.price ?? ''}',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(32), color: Colors.orange),
        ),
        TextSpan(
          text: '  ${itemData.zonename ?? ''}',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.grey),
        ),
      ]),
    );
  }

  /// 处理文字转成富文本组件
  List<TextSpan> _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    // List<String> arr = word.split(keyword); // 切割数组
    TextStyle normalStyle = TextStyle(
      fontSize: ScreenUtil().setSp(32),
      color: Colors.black87,
    );
    // 关键字文字样式
    TextStyle keywordStyle = TextStyle(
      fontSize: ScreenUtil().setSp(32),
      color: Colors.red,
    );

    // 匹配字符串正则
    RegExp reg = new RegExp(
      r"(" + keyword + ")", // 加字母"r"，字符串不会解析转义""
      multiLine: true, // 碰到换行字符串也不会停止
      caseSensitive: false, // 不区分大小写
    );
    RegExp regTag = RegExp(r"<-- (.*) -->"); // 不区分大小写原内容标记

    List<String> keyMatchs = []; // 转换后的文本内容

    // 处理文字切割
    word.splitMapJoin(
      reg, // 正则条件
      // 每个匹配通过调用onMatch转换成字符串
      onMatch: (m) {
        if (RegExp(keyword).hasMatch(m.group(0))) {
          keyMatchs.add('<-- ${m.group(0)} -->');
        }
        keyMatchs.add('<-- ${m.group(0)} -->');
        return '';
      },
      // 每个非匹配部分通过调用onNonMatch来进行转换
      onNonMatch: (n) {
        keyMatchs.add(n);
        return n;
      },
    );

    for (var i = 0; i < keyMatchs.length; i++) {
      String itemStr = keyMatchs[i];
      if (regTag.hasMatch(itemStr)) {
        // 匹配不区分大小写的内容
        spans.add(
          TextSpan(text: regTag.firstMatch(itemStr)[1], style: keywordStyle),
        );
      } else if (itemStr != null && itemStr.length > 0) {
        spans.add(TextSpan(text: itemStr, style: normalStyle));
      }
    }
    return spans;
  }
}
