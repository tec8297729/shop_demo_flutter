import '../../components/PageLoding/PageLoding.dart';
import '../Cart/provider/cartStore.dart';
import '../GoodsDetailsInfo/components/DetailsBottom.dart';
import '../GoodsDetailsInfo/components/DetailsWeb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/goodsDetailsInfo_stroe.dart';
import 'components/DetailsExplanin.dart';
import 'components/DetailsTopArea.dart';
import 'components/DetailsTabBar.dart';
import 'package:async/async.dart' show AsyncMemoizer;

class GoodsDetailsInfo extends StatefulWidget {
  GoodsDetailsInfo({Key key, this.params});
  final Map params;

  @override
  _GoodsDetailsInfoState createState() => _GoodsDetailsInfoState();
}

class _GoodsDetailsInfoState extends State<GoodsDetailsInfo>
    with SingleTickerProviderStateMixin {
  final _memoizer = AsyncMemoizer<Map>();

  bool get wantKeepAlive => true;
  GoodsDetailsInfoStore goodsStore;

  // 请求详情页数据
  Future _getGoodsInfo() async {
    return _memoizer.runOnce(() async {
      Map goodsInfo = await goodsStore.getGoodsInfo(widget.params['goodsId']);
      // 更新当前详情商品数量
      await Provider.of<CartStore>(context).changeGoodsSum(goodsInfo);
      return goodsInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    goodsStore = Provider.of<GoodsDetailsInfoStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: _getGoodsInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                contextWidget(),
                bottomBuyWiget(),
              ],
            );
          }
          return PageLoading();
        },
      ),
    );
  }

  // 商品详情介绍
  Widget contextWidget() {
    return Container(
      child: ListView(
        children: <Widget>[
          DetailsTopArea(),
          DetailsExplanin(),
          DetailsTabBar(),
          DetailsWeb(),
        ],
      ),
    );
  }

  // 底部菜单购买栏
  Widget bottomBuyWiget() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: DetailsBottom(),
    );
  }
}
