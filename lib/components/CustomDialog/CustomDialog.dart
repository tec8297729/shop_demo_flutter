import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 简易版本自定义弹层组件
class CustomDialog extends StatefulWidget {
  CustomDialog({
    this.child,
    this.width: 320,
    this.hiddenTitle = false,
    this.bottomWidget,
    this.title,
    this.onPressed,
    this.cancelTitle,
    this.confirmTitle,
    this.showClose: true,
  });

  /// 内容区显示组件
  final Widget child;

  /// 弹层宽度
  final double width;

  /// 自定义底部组件
  final Widget bottomWidget;

  /// 标题文字
  final String title;

  /// 是否隐藏标题
  final bool hiddenTitle;

  /// 确认按钮点击事件
  final VoidCallback onPressed;

  final String cancelTitle;
  final String confirmTitle;

  /// 是否显示关闭按钮
  final bool showClose;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedContainer(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeInCubic,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular((8.0)),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  width: widget.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _titleWidget(),
                      // 内容区域
                      Flexible(child: widget.child),
                      Divider(),
                      _bottomWidget(context), // 底部
                    ],
                  ),
                ),
                // 关闭按钮
                if (widget.showClose)
                  Positioned(
                    right: 10.0,
                    top: 11.0,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 26, color: Colors.black38),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 标题组件
  Widget _titleWidget() {
    if (widget.hiddenTitle && !widget.showClose) {
      return Container(margin: EdgeInsets.symmetric(vertical: 10));
    } else if (widget.hiddenTitle) {
      return Container(margin: EdgeInsets.symmetric(vertical: 20));
    }

    return Offstage(
      offstage: widget.hiddenTitle,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          widget.hiddenTitle ? '' : widget.title,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  /// 底部区域
  Widget _bottomWidget(BuildContext context) {
    TextStyle _textStyle = TextStyle(fontSize: 18);
    if (widget.bottomWidget != null) return widget.bottomWidget;

    return Container(
      height: ScreenUtil().setHeight(88),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: Text(widget.cancelTitle ?? '取消', style: _textStyle),
              textColor: Color(0xFF999999),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(88),
            width: 0.6,
            child: const VerticalDivider(),
          ),
          Expanded(
            child: FlatButton(
              child: Text(widget.confirmTitle ?? '确认', style: _textStyle),
              textColor: Theme.of(context).primaryColor,
              onPressed: widget.onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
