import 'package:baixing/utils/util.dart' show SpUtil;
import 'package:flutter/material.dart';
import '../../../services/service_method.dart';

class GoodsDetailsInfoStore with ChangeNotifier {
  var goodsInfo = {};
  int selectTab = 0; // 当前选中的tab索引

  // 获取详情商品数据
  Future getGoodsInfo(String id) async {
    SpUtil.getInstance();
    Map<String, String> formData = {'goodId': id};
    var res = await getGoodDetailById(formData);
    if (res['data'] != null) {
      goodsInfo = res['data']['goodInfo'] ?? {};
    }
    // print(goodsInfo);
    return goodsInfo;
  }

  // tab切换方法
  changeTabs(int index) {
    selectTab = index;
    notifyListeners();
  }
}
