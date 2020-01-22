import 'package:baixing/service/service_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryGoodsListStore with ChangeNotifier {
  List goodsList = [];
  String _categoryId = '4'; // 大类ID
  String _subId = ''; // 小类ID
  int _page = 1;
  String noMoreText = ''; // 显示没有数据的文字
  ScrollController scrollControll = ScrollController(); // 滚动控制器
  EasyRefreshController easyRefreshController = EasyRefreshController();
  BuildContext _context;

  set setContext(BuildContext context) => this._context = context;

  // 列表接口请求
  fetchGetGoodsList({bool isAddData = false}) async {
    Map data = {
      'categoryId': _categoryId,
      'categorySubId': _subId,
      'page': _page,
    };

    var res = await getMallGoods(data);
    var resData = res['data']; // 列表数据
    // print('分类列表>>>>$data');

    // 容错，接口返回是否有数据
    if (resData != null) {
      // 是否追加数据，或是重置list数据
      isAddData ? goodsList.addAll(resData) : goodsList = resData;
    } else {
      noMoreText = (resData == null) ? '没有更多了' : '';
      print('没有更多了');
      Fluttertoast.showToast(
        msg: '没有更多商品了',
        toastLength: Toast.LENGTH_SHORT, // 提示大小，short短提示
        gravity: ToastGravity.CENTER, // 提示位置，CENTER居中
        backgroundColor: Theme.of(_context).backgroundColor, // 背景颜色
        textColor: Colors.white, // 文字颜色
        fontSize: 16, // 提示文字大小
      );
    }

    notifyListeners();

    return resData;
  }

  // 下拉刷新
  Future<void> refreshGoodsList() async {
    _page = 1;
    noMoreText = ''; // 显示没有数据的文字
    await fetchGetGoodsList();
    easyRefreshController.finishRefresh(success: true); // 完成刷新
  }

  // 上拉加载
  Future<void> getListMore() async {
    _page++;
    var res = await fetchGetGoodsList(isAddData: true);
    bool noMoreFlag = false;
    if (res == null) {
      _page--;
      noMoreFlag = true;
      // scrollControll.animateTo(
      //   scrollControll.position.maxScrollExtent - 60,
      //   curve: Curves.easeInOut,
      //   duration: Duration(seconds: 1), // 页面跳转过渡整体时间
      // );
    }
    // 完成加载，并且刷新
    easyRefreshController.finishLoad(success: true, noMore: noMoreFlag);
  }

  // 获取更新右侧商品列表(左侧及nav点击)
  void getGoodsList({String categoryId, String categorySubId, int page}) async {
    _categoryId = categoryId == null ? '4' : categoryId;
    _subId = categorySubId ?? '';
    _page = page != null ? page : 1;
    noMoreText = '';
    // print('ID>>>${data}');
    await fetchGetGoodsList();
    // 当滚动组件实例化显示的时候，才操作
    if (scrollControll.positions.isNotEmpty) {
      scrollControll.jumpTo(0); // 滚动顶部
    }
  }
}
