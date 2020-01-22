import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartStore extends ChangeNotifier {
  String cartString = '[]'; // 临时整体购物车数据
  String cacheKey = 'cartInfo'; // 缓存key
  double allPrice = 0; // 总金额
  int allGoodsitem = 0; // 商品总数量
  bool isAllCheck = true;
  num goodsSum = 0; // 当前商品数量

  // json转换成字符串
  jsonToString(data) {
    return jsonEncode(data);
  }

  // 转换成json格式
  List<Map> toJsonData(String data) {
    var temp = cartString == null ? [] : jsonDecode(data ?? '[]');
    return (temp as List).cast<Map>();
  }

  // 获取购物车数据（缓存）
  Future<List<Map>> getCartInfo([flag = true]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cacheKey);
    List<Map> allData = toJsonData(cartString);
    if (flag) checkCalculate(allData); // 计算总额
    return allData;
  }

  // 加入购物车事件，保存商品数据及存到缓存
  save(Map goodsInfo, {@required int count}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cacheKey);
    goodsInfo['count'] ??= 1; // 初始化商品数量

    // 强制转换类型json化
    List<Map> tempList = toJsonData(cartString);
    bool isHave = false; // 记录是否已有数据
    for (var i = 0; i < tempList.length; i++) {
      if (tempList[i]['goodsId'] == goodsInfo['goodsId']) {
        // 更改传入的商品数据
        tempList[i]['count']++; // 增加当前商品数量
        isHave = true;
        goodsSum = tempList[i]['count']; // 当前商品数量
        break;
      }
      goodsSum = 0;
    }

    if (!isHave) {
      // 当缓存中没有此商品数据时，添加一条新商品数据进去
      goodsInfo['isSelect'] = true; // 初始化购物车选中
      tempList.add(goodsInfo);
    }
    // print('保存商品${jsonToString(tempList)}');
    // 加入持久缓存中
    prefs.setString(cacheKey, jsonToString(tempList));
    notifyListeners();
  }

  // 更改当前商品勾选状态
  changeIsSelect(Map itemData, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map> allData = await getCartInfo(false);
    for (var i = 0; i < allData.length; i++) {
      if (allData[i]['goodsId'] == itemData['goodsId']) {
        // 更改当前商品是否选中
        allData[i]['isSelect'] = val;
        // print('商品当前状态${allData[i]['isSelect']}');
        break;
      }
    }
    checkCalculate(allData);
    prefs.setString(cacheKey, jsonToString(allData));
    notifyListeners();
  }

  // 删除单个购物车商品
  deleteOneGoods(Map itemData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map> allData = await getCartInfo(false);
    for (var i = 0; i < allData.length; i++) {
      if (allData[i]['goodsId'] == itemData['goodsId']) {
        allData.removeAt(i); // 移除当前数据
        break;
      }
    }
    checkCalculate(allData);
    prefs.setString(cacheKey, jsonToString(allData));
    notifyListeners();
  }

  // 移除所有商品
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(cacheKey);
    cartString = '[]';
    print('清空缓存完成----------');
    notifyListeners();
  }

  // 统计选中商品
  checkCalculate(List allData) {
    // 重置统计
    allPrice = 0;
    allGoodsitem = 0;
    isAllCheck = true; // 是否全选
    for (var i = 0; i < allData.length; i++) {
      if (allData[i]['isSelect']) {
        // 统计选中的商品总数量金额
        allPrice += (allData[i]['count'] * allData[i]['presentPrice']);
        allGoodsitem++;
      } else {
        isAllCheck = false; // 只要有一个不是全选就标记
      }
    }
  }

  // 全选按钮事件
  changeAllSelectBtnState(bool isSelect) async {
    // 重置统计
    allPrice = 0;
    allGoodsitem = 0;
    isAllCheck = isSelect; // 全选按钮状态

    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(cacheKey);
    List<Map> allData = toJsonData(cartString);
    for (var i = 0; i < allData.length; i++) {
      if (isSelect) {
        // 统计选中的商品总数量金额
        allPrice += allData[i]['count'] * allData[i]['presentPrice'];
        allGoodsitem++;
      }
      allData[i]['isSelect'] = isSelect; // 全部商品勾选状态
    }
    prefs.setString(cacheKey, jsonToString(allData)); // 存入缓存
    notifyListeners();
  }

  // 商品添加或减少
  addOrReduceGoodsCount(int index, {type: 'reduce'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map> allGoodsData = await getCartInfo();
    Map itemGoods = allGoodsData[index]; // 当前商品数据
    switch (type) {
      case 'reduce':
        if (itemGoods['count'] != 1) itemGoods['count']--;
        break;
      case 'add':
        itemGoods['count']++;
        break;
      default:
    }
    allGoodsData[index] = itemGoods; // 指定商品更新数据
    prefs.setString(cacheKey, jsonToString(allGoodsData)); // 存入缓存
    notifyListeners();
  }

  // 统计当前商品数量
  changeGoodsSum(Map goodsInfo) async {
    List<Map> tempList = await getCartInfo();
    for (var i = 0; i < tempList.length; i++) {
      if (tempList[i]['goodsId'] == goodsInfo['goodsId']) {
        goodsSum = tempList[i]['count']; // 当前商品数量
        break;
      }
      goodsSum = 0;
    }
    // notifyListeners();
  }
}
