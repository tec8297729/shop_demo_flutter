import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [home] 首页高亮模式
enum SearchBarType { home, normal, homeLight }

/// 搜索组件
class SearchBar extends StatefulWidget {
  /// 左侧区域文字
  final String leftTitle;

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

  /// 右侧搜索点击事件
  final void Function() rightButtonClick;

  /// 语音点击按钮
  final void Function() speakClick;

  /// 键盘回车事件
  final void Function() keyEnterFn;

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
      this.inputBoxClick,
      this.leftTitle,
      this.keyEnterFn})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false; // 是否显示清除按钮
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 初始化输入框内容
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

  /// 搜索页面显示的组件
  Widget _genNormalSearch() {
    return Container(
      margin: EdgeInsets.only(left: 10),
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
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          // 左侧区域
          _wrapTap(
            onTap: widget.leftButtonClick,
            child: Container(
              padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: Row(
                children: <Widget>[
                  Text(
                    widget.leftTitle ?? '上海',
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
        autofocus: true, // 自动获取焦点
        onChanged: _onChanged,
        // 键盘回车事件
        onEditingComplete: () {
          if (widget.keyEnterFn != null) widget.keyEnterFn();
        },
        style: TextStyle(
          fontSize: ScreenUtil().setSp(36),
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        // 输入文本样式
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, -20, 5, 0),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
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

          // 右侧区域
          _rightIconWidget(),
        ],
      ),
    );
  }

  // 输入框右侧图标区域
  _rightIconWidget() {
    if (showClear) {
      // 清空图标
      return GestureDetector(
        child: Icon(
          Icons.clear,
          size: ScreenUtil().setSp(44),
          color: Colors.grey,
        ),
        onTap: () {
          // 清空输入框内容
          _controller.clear();
          _onChanged(''); // 更新视图
        },
      );
    }

    // 语音图标
    return _wrapTap(
      child: Icon(
        Icons.mic,
        size: ScreenUtil().setSp(44),
        color: Colors.grey,
      ),
      onTap: () {
        print('语音点击');
        if (widget.speakClick != null) {
          widget.speakClick();
        }
      },
    );
  }

  // 输入框事件
  _onChanged(String text) {
    if (widget.onChanged != null) {
      widget.onChanged(text); // 回调
    }
    // 有文字内容时，才显示清空图标
    setState(() {
      showClear = (text.length > 0);
    });
  }

  // 首页前景色
  _homeFontColor() {
    // 判断是否是高亮状态，高亮显示黑色
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
