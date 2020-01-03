import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [home] 首页高亮模式
enum SearchBarType { home, normal, homeLight }

/// 搜索组件
class SearchBar extends StatefulWidget {
  /// 是否启用搜索
  final bool enabled;

  /// 是否隐藏左侧icon区域
  final bool hideLeft;

  /// 搜索组件显示的类型
  final SearchBarType searchBarType;

  /// 默认输入框显示的内容
  final String hint;

  /// 默认提示内容（输入框区域）
  final String defaultText;

  /// 左侧图标点击事件
  final void Function() leftButtonClick;

  /// 右侧图标点击事件
  final void Function() rightButtonClick;

  /// 语音点击按钮
  final void Function() speakClick;

  /// 输入框点击事件
  final void Function() inputBoxClick;

  /// 输出框内容变化回调
  final ValueChanged<String> onChanged;

  const SearchBar(
      {Key key,
      this.enabled = true,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.onChanged,
      this.inputBoxClick})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false; // 是否显示清除按钮
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchBarType == SearchBarType.normal) {
      return _genNormalSearch();
    }
    return _genHomeSearch();
  }

  Widget _genNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
            child: widget?.hideLeft ?? false
                ? null
                : Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: ScreenUtil().setSp(52),
                  ),
            onTap: widget.leftButtonClick,
          ),
          // 输入框
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),

          // 右侧区域
          _wrapTap(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                '搜索',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: ScreenUtil().setSp(34),
                ),
              ),
            ),
            onTap: widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  /// 首页搜索组件
  Widget _genHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          // 左侧区域
          _wrapTap(
            child: Container(
              padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: Row(
                children: <Widget>[
                  Text(
                    '上海',
                    style: TextStyle(
                      color: _homeFontColor(), // 颜色
                      fontSize: ScreenUtil().setSp(28),
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: _homeFontColor(),
                    size: ScreenUtil().setSp(44),
                  ),
                ],
              ),
            ),
          ),
          // 中间输入框区域
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),

          // 右侧区域
          _wrapTap(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Icon(
                Icons.comment,
                color: _homeFontColor(),
                size: ScreenUtil().setSp(52),
              ),
            ),
            onTap: widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  /// 点击基础组件
  Widget _wrapTap({Widget child, VoidCallback onTap}) {
    if (child == null) return Container();
    return Container(
      child: GestureDetector(
        onTap: onTap != null ? onTap : null,
        child: child,
      ),
    );
  }

  /// 输入框组件
  Widget _inputBox() {
    Color inputBoxColor = Color(int.parse('0xffEDEDED'));
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white; // 输入框白色
    }

    // 是否是首页
    bool normalFlag = widget.searchBarType == SearchBarType.normal;
    Widget inputChild; // 输出框样式组件
    if (normalFlag) {
      inputChild = TextField(
        controller: _controller,
        onChanged: _onChanged,
        autofocus: true, // 自动获取焦点
        style: TextStyle(
          fontSize: ScreenUtil().setSp(36),
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        // 输入文本样式
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          border: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: TextStyle(fontSize: ScreenUtil().setSp(30)),
        ),
      );
    } else {
      // 首页情况下的搜索框组件，不可点击
      inputChild = _wrapTap(
        child: Text(
          widget.defaultText,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(26),
            color: Colors.grey,
          ),
        ),
        onTap: widget.inputBoxClick,
      );
    }

    return Container(
      height: ScreenUtil().setHeight(60),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      // 整体输入框的背景颜色控制
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(normalFlag ? 5 : 15),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 20,
            color: normalFlag ? Color(0xffA9A9A9) : Colors.blue,
          ),
          // 中间区域输入框
          Expanded(
            flex: 1,
            child: inputChild,
          ),

          !showClear
              ? _wrapTap(
                  child: Icon(
                    Icons.mic,
                    size: ScreenUtil().setSp(44),
                    color: Colors.grey,
                  ),
                  onTap: () {
                    // 清空输入框内容
                    _controller.clear();
                    _onChanged('');
                  },
                )
              : null,
        ],
      ),
    );
  }

  // 输入框事件
  _onChanged(String text) {
    // 有文字内容时，才显示清空图标
    setState(() {
      showClear = text.length > 0;
    });
    if (widget.onChanged != null) {
      widget.onChanged(text); // 回调
    }
  }

  // 首页前景色
  _homeFontColor() {
    // 判断是否是高亮状态，高亮显示黑色
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
