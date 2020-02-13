import 'package:baixing/components/MyAppBar/MyAppBar.dart';
import 'package:baixing/components/CustomDialog/CustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/ChangePassWordModal.dart';
import 'components/MoneyCart.dart';
import 'components/SMSVerifyDialog.dart';

/// 提现密码页面
class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '提现密码'),
      body: Container(
        child: Column(
          children: <Widget>[
            MoneyCart(),
            clickItem('修改密码', onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_context) => ChangePassWordModal(),
              );
            }),
            clickItem('忘记密码', onTap: _confirmDialog),
          ],
        ),
      ),
    );
  }

  /// 确认提现弹层
  _confirmDialog() {
    showGeneralDialog(
      context: context,
      barrierLabel: "confirmDialog",
      barrierColor: Colors.black38, // 遮罩层背景色
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 150), // 弹出的过渡时长
      transitionBuilder: (context, animation1, animation2, Widget child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(animation1),
          child: child,
        );
      },
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        return CustomDialog(
          onPressed: () {
            Navigator.pop(context);
            _noteVerifyDialog();
          },
          hiddenTitle: true,
          showClose: false,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              '为了您的账户安全需先进行短信验证并设置提现密码。',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 短信验证弹层
  _noteVerifyDialog() {
    showGeneralDialog(
      context: context,
      barrierLabel: "短信验证",
      barrierColor: Colors.black38, // 遮罩层背景色
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 150), // 弹出的过渡时长
      transitionBuilder: (context, animation1, animation2, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation1),
          child: child,
        );
      },
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        return StatefulBuilder(builder: (context, StateSetter _setState1) {
          return SMSVerifyDialog();
        });
      },
    );
  }

  // 列表卡片
  Widget clickItem(String title, {Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
        constraints:
            BoxConstraints(maxHeight: double.infinity, minHeight: 50.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.6),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
