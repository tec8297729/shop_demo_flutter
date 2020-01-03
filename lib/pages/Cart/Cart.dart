import 'package:baixing/components/PageLoding/PageLoding.dart';
import 'package:baixing/pages/Cart/components/CartBottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './model/cartStore.dart';
import './components/CartItem.dart';

// 购物车页面
class Cart extends StatefulWidget {
  Cart({Key key, this.params}) : super(key: key);
  final params;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartStore cartStore;

  @override
  void initState() {
    super.initState();
  }

  // 查询当前商品数据
  Future<List<Map>> getCartInfo() async {
    return await cartStore.getCartInfo();
  }

  @override
  Widget build(BuildContext context) {
    cartStore = Provider.of<CartStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: getCartInfo(),
        builder: (context, snaphost) {
          if (snaphost.hasData) {
            List listData = snaphost.data;

            return Stack(
              children: <Widget>[
                // 滚动列表渲染
                Container(
                  margin: EdgeInsets.only(bottom: 80), // 处理底部被遮挡部份
                  child: ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return CartItem(listData[index], index);
                    },
                  ),
                ),
                // 底部组件
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                ),
              ],
            );
          }

          return PageLoading();
        },
      ),
    );
  }
}
