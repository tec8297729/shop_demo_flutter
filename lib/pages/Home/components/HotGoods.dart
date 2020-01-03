import 'package:baixing/service/service_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotGoods extends StatefulWidget {
  List<Map> hotGoodsList;
  HotGoods({Key key, @required this.hotGoodsList});

  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  // int page = 1;
  // List<Map> hotGoodsList = [];

  @override
  void initState() {
    super.initState();
    // _getHotGoods();
  }

  // void _getHotGoods() async {
  //   Map formPage = {'page': page};
  //   var res = await getHomePageBeloContent(formPage);
  //   print(res);
  //   List<Map> newGoodsList = (res['data'] as List).cast<Map>();
  //   setState(() {
  //     newGoodsList.addAll([...newGoodsList]);
  //     page++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
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

      return Wrap(
        spacing: 3,
        children: listWidget,
      );
    }

    return Container();
  }
}
