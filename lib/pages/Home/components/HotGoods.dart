import '../../../service/service_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// 火爆专区商品布局
class HotGoods extends StatefulWidget {
  List<Map> hotGoodsList;
  HotGoods({Key key, @required this.hotGoodsList});

  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        hotTitle,
        _wrapList(),
      ],
    );
  }

  // 主标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    // height: ScreenUtil().setHeight(44),
    padding: EdgeInsets.all(5),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text(
      '火爆专区',
      style: TextStyle(
        fontSize: ScreenUtil().setSp(32),
      ),
    ),
  );

  // 列表
  Widget _wrapList() {
    if (widget.hotGoodsList.length != 0) {
      List<Widget> listWidget = widget.hotGoodsList.map((val) {
        return GestureDetector(
          // 商品点击事件
          onTap: () {
            Navigator.pushNamed(context, '/goodsDetailsInfo', arguments: {
              'goodsId': val['goodsId'],
            });
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(0.5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil().setSp(26),
                  ),
                ),
                // 文字区域
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    ),
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough, // 删除线
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      // return StaggeredGridView.countBuilder(
      //   physics: NeverScrollableScrollPhysics(), // 禁止滚动
      //   shrinkWrap: true, // 占位一定高度
      //   crossAxisCount: 2, // 几列布局
      //   itemCount: listWidget.length, // 总数量
      //   // 渲染布局的组件
      //   itemBuilder: (BuildContext context, int index) {
      //     return listWidget[index];
      //   },
      //   // 合并item方法，自定义合并主轴及次轴几格参数
      //   staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      //   // mainAxisSpacing: 14.0, // 每个元素底部间隔
      //   // crossAxisSpacing: 4.0, // 每个元素左右间隔大小
      // );

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }

    return Container();
  }
}
