import 'package:baixing/pages/LoginPage/components/MyInput.dart';
import 'package:baixing/routes/routerName.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/FadeAnimation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  String cacheKey = "loginUser";
  bool userFlag = false;
  bool pwdFlag = false;

  @override
  void initState() {
    super.initState();
    userController.text = SpUtil.getData(cacheKey, defValue: "");
  }

  /// 登录验证
  loginCaptcha() {
    if (userController.text.length > 6 && pwdController.text.length > 6) {
      SpUtil.setData(cacheKey, userController.text);
      Navigator.pushReplacementNamed(context, RouterName.home);
      return;
    }
    Util.toastTips('帐号密码不正确或不足六位');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _headerBg(),
            _userPasswor(),
            _loginBtn(),
            _forgotPassword(),
          ],
        ),
      ),
    );
  }

  /// 头部背景
  Widget _headerBg() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(800),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/log_images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          _lightWidget(
            delay: 1,
            left: 30,
            height: 400,
            imgName: 'light-1.png',
          ),
          _lightWidget(
            delay: 1.3,
            left: 160,
            height: 300,
            imgName: 'light-2.png',
          ),
          _lightWidget(
            delay: 1.5,
            rihgt: 40,
            top: 70,
            width: 130,
            height: 130,
            imgName: 'clock.png',
          ),
          _title(), // 标题
        ],
      ),
    );
  }

  /// 背景标题
  Widget _title() {
    return Positioned(
      child: FadeAnimation(
        delay: 1.6,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(80),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 灯背景图组件
  Widget _lightWidget({
    double left,
    double rihgt,
    double top,
    double width: 160,
    double height: 400,
    String imgName,
    double delay: 1,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: rihgt,
      width: ScreenUtil().setWidth(width),
      height: ScreenUtil().setHeight(height),
      child: FadeAnimation(
        delay: delay,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/log_images/$imgName'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  /// 帐号密码
  Widget _userPasswor() {
    return Container(
      margin: EdgeInsets.fromLTRB(35, 0, 35, 35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(143, 148, 251, 1),
            offset: Offset(0, 10),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          MyInput(
            controller: userController,
            hintText: '请输入帐号',
            inputFormatters: [
              BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]')),
              LengthLimitingTextInputFormatter(11),
            ],
            isNext: true,
          ),
          MyInput(
            controller: pwdController,
            hintText: '请输入密码',
            inputFormatters: [
              BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]')),
              LengthLimitingTextInputFormatter(8),
            ],
            isInputPwd: true,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  /// 登录按钮
  Widget _loginBtn() {
    return InkWell(
      onTap: loginCaptcha,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(40, 6, 40, 60),
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 158, 251, 1),
            Color.fromRGBO(143, 158, 251, .6),
          ]),
        ),
        child: Text(
          '登录',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(40),
            letterSpacing: 12,
          ),
        ),
      ),
    );
  }

  /// 底部忘记密码
  Widget _forgotPassword() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: GestureDetector(
        onTap: () {
          Util.toastTips('嘿嘿！别闹~密码随意输入');
        },
        child: Text(
          '忘记密码?',
          style: TextStyle(
            color: Color.fromRGBO(143, 148, 251, 1),
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(32),
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}
