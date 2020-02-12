import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 修改密码弹层
class ChangePassWordModal extends StatefulWidget {
  @override
  _ChangePassWordModalState createState() => _ChangePassWordModalState();
}

class _ChangePassWordModalState extends State<ChangePassWordModal> {
  Color borderColor = const Color(0xFFcccccc);
  int _codeIndex = 0; // code存储索引
  List<String> _codeList = ['', '', '', '', '', ''];
  List<String> _keyboardList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '',
    '0',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // 标题
              Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(120),
                child: Text(
                  '设置提现密码',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(38),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              _passwdWrap(),
              Container(
                // margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  '提现密码不可为连续、重复的数字。',
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _customKeyboard(),
                  ],
                ),
              ),
            ],
          ),
          // 关闭按钮
          Positioned(
            right: 16.0,
            top: 17.0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close, size: 26),
            ),
          ),
        ],
      ),
    );
  }

  /// 密码输入框组件
  Widget _passwdWrap() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
      height: ScreenUtil().setHeight(90),
      // color: Colors.red,
      decoration: BoxDecoration(
        border: Border.all(width: 0.6, color: borderColor),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: <Widget>[
          for (var p = 0; p < _codeList.length; p++)
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // 最后一个不加边框颜色
                  border: (_codeList.length - 1) != p
                      ? Border(
                          right: Divider.createBorderSide(context,
                              color: borderColor, width: 0.6),
                        )
                      : null,
                ),
                child: Text(
                  _codeList[p].isEmpty ? '' : '●',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 自定义密码键盘
  Widget _customKeyboard() {
    return Container(
      padding: EdgeInsets.only(top: 1),
      color: Colors.black12,
      child: GridView.builder(
        shrinkWrap: true, // 是否根据子widget的总长度来设置ListView的长度
        physics: NeverScrollableScrollPhysics(), // 禁止滚动
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 每行多少个元素
          mainAxisSpacing: 0.6, // 每个元素底部间隔
          crossAxisSpacing: 0.6, // 每个元素左右间隔大小
          childAspectRatio: 1.953, // // 按比例设置盒子大小（宽/高）
        ),
        itemCount: _keyboardList.length, // 总数量
        // 渲染布局的组件
        itemBuilder: (context, int index) {
          return _customKeyboardItem(index);
        },
      ),
    );
  }

  /// 数字键盘
  Widget _customKeyboardItem(int index) {
    // 判断是否最后一个,或倒数第三个
    bool isEnd = (_keyboardList.length - 1) == index;
    bool isEnd3 = (_keyboardList.length - 3) == index;
    bool isBgColor = isEnd || isEnd3;

    return Material(
      color: isBgColor ? Color(0xFFF2F2F2) : null,
      child: InkWell(
        onTap: !isEnd3
            ? () {
                _onTapKeyboard(index);
              }
            : null,
        child: Container(
          alignment: Alignment.center,
          child: !isEnd
              ? Text(
                  '${_keyboardList[index] ?? ''}',
                  style: TextStyle(fontSize: 26.0),
                )
              : Image.asset(
                  'asset/images/del.png',
                  width: ScreenUtil().setWidth(77),
                ),
        ),
      ),
    );
  }

  /// 键盘点击事件
  _onTapKeyboard(int index) {
    bool isEnd = (_keyboardList.length - 1) == index;
    int keyLen = _codeList.length;
    setState(() {
      // X删除操作
      if (isEnd) {
        if (_codeIndex == 0) return;
        _codeList[--_codeIndex] = '';
        return;
      }

      _codeList[_codeIndex] = _keyboardList[index];
      _codeIndex++; // 记录索引
      if (_codeIndex >= keyLen) {
        String code = '';
        for (var i = 0; i < _codeList.length; i++) {
          code += _codeList[i];
          _codeList[i] = '';
        }
        _codeIndex = 0;

        Util.toastTips('密码：$code');
      }
    });
  }
}
