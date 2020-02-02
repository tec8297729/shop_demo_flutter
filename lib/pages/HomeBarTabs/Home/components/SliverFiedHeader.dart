import 'package:flutter/material.dart';

class SliverFiedHeader extends StatefulWidget {
  @override
  _SliverFiedHeaderState createState() => _SliverFiedHeaderState();
}

class _SliverFiedHeaderState extends State<SliverFiedHeader> {
  var _selectType;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: SliverAppBarDelegate(
        child: Container(
          width: double.infinity,
          height: 298,
          child: Column(
            children: <Widget>[
              // RaisedButton(
              //   onPressed: () {},
              //   child: Text('data'),
              // ),
              PopupMenuButton(
                onSelected: (value) {}, // 点击选项事件
                offset: Offset(0, 100), // 偏移位置，x轴, y轴，默认是显示在按钮上的（难看）
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: {'hhhh': '232'}, // 点击事件可以获取到值，可以存任何数据类型
                      child: Text('自定义显示的组件1'),
                    ),
                    PopupMenuItem(
                      value: {'hhhh': '555'},
                      child: Text('自定义显示的组件2'),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  SliverAppBarDelegate({this.child, this.height = 80});

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    oldDelegate.maxExtent; // 自定义判断,返回false者不重新渲染组件,优化部份
    return true;
  }
}
