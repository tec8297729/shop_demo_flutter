import 'dart:async';

import 'package:baixing/components/CustomDialog/CustomDialog.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SMSVerifyDialog extends StatefulWidget {
  @override
  _SMSVerifyDialogState createState() => _SMSVerifyDialogState();
}

class _SMSVerifyDialogState extends State<SMSVerifyDialog> {
  bool sendCode = false; // 是否隐藏获取验证码文字
  int countdown = 60; // 倒计时
  Timer _timer;
  List<String> _codeList = ['', '', '', '', '', ''];
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// 倒计60秒
  _time60() {
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        countdown--;
        if (countdown == 0) {
          _timeRest();
        }
      });
    });
  }

  // 重置
  _timeRest() {
    setState(() {
      countdown = 60;
      sendCode = false;
      _timer?.cancel();
      _timer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '短信验证',
      child: _noteVerifyDialogContext(),
      bottomWidget: _noteVerifyDialogBottom(),
    );
  }

  /// 短信验证内容区域
  Widget _noteVerifyDialogContext() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Text(
              '本次操作需短信验证，验证码会发送至您的注册手机 15000000000',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              _inputTextField(),
              GestureDetector(
                onTap: () {
                  _focusNode.requestFocus();
                },
                child: _inputReadOnly(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 验证码数字显示组件
  Widget _inputReadOnly() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (var i = 0; i < 6; i++)
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(72),
            width: ScreenUtil().setWidth(72),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.6,
                color: _codeList[i].isNotEmpty
                    ? Theme.of(context).primaryColor
                    : Color(0xFFcccccc),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              _codeList[i],
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
              ),
            ),
          ),
      ],
    );
  }

  /// 输入组件
  Widget _inputTextField() {
    return EditableText(
      controller: _controller, // 文字框组件控制器
      focusNode: _focusNode, // 光标控制
      keyboardType: TextInputType.number, // 键盘弹出的类型
      // 输入限制条件定义
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly, // 0-9之间
        LengthLimitingTextInputFormatter(6), // 只让输入6位
      ],
      // 隐藏光标与字体颜色，达到隐藏输入框的目的
      cursorColor: Colors.transparent, // 光标颜色
      cursorWidth: 0, // 光标宽度
      textAlign: TextAlign.left, // 文字对齐方式
      backgroundCursorColor: Colors.transparent, // 背景颜色
      style: TextStyle(color: Colors.transparent, fontSize: 32), // 文字样式
      // 输入框内容改变时触发,返回输入框内容
      onChanged: (String v) {
        setState(() {
          if (_codeList.length <= v.length) {
            Util.toastTips('验证码：${_controller.text}');
            for (var i = 0; i < _codeList.length; i++) {
              _codeList[i] = '';
            }
            _controller.text = '';
            return;
          }

          for (var i = 0; i < _codeList.length; i++) {
            try {
              _codeList[i] = v[i];
            } catch (e) {
              _codeList[i] = '';
            }
          }
        });
      },
    );
  }

  /// 短信验证,底部按钮
  Widget _noteVerifyDialogBottom() {
    return InkWell(
      onTap: !sendCode
          ? () {
              sendCode = true;
              _time60();
            }
          : null,
      child: Container(
        height: ScreenUtil().setHeight(80),
        child: Text(
          !sendCode ? '获取验证码' : '已发送($countdown s)',
          style: TextStyle(
            color: sendCode ? Colors.black26 : Colors.blue,
            fontSize: ScreenUtil().setSp(38),
          ),
        ),
      ),
    );
  }
}
