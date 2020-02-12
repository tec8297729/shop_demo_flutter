import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 标签tags栏组件
class BottomTags extends StatefulWidget {
  @override
  _BottomTagsState createState() => _BottomTagsState();
}

class _BottomTagsState extends State<BottomTags> {
  List<bool> clickIndex = [false, false, false, false];
  List<String> btnData = ['津贴优惠', '会员领红包', '满减优惠', '品质联盟'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 17),
      child: Row(
        children: <Widget>[
          for (var i = 0; i < btnData.length; i++) tagBtn(btnData[i], index: i),
        ],
      ),
    );
  }

  /// tag按钮
  Widget tagBtn(String title, {int index = 0}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          clickIndex[index] = !clickIndex[index];
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(150),
        height: ScreenUtil().setHeight(50),
        margin: EdgeInsets.only(right: index != 3 ? 13 : 0), // 最后一个没边距
        color: clickIndex[index] ? Color(0xFFE7F8FF) : Colors.black12,
        child: Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(26),
            color: clickIndex[index] ? Color(0xFF5DB4C6) : Colors.black,
          ),
        ),
      ),
    );
  }
}
