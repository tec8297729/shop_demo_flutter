import 'package:baixing/pages/nCoVPage/model/myCity_model.dart';
import 'package:baixing/pages/nCoVPage/model/ncvOverall_model.dart';

import './servcie_url.dart';
import '../models/search_model.dart';
import '../utils/dio/safeRequest.dart';
import 'package:dio/dio.dart';

final tokenData = {'lon': '115.02932', 'lat': '35.76189'};

/// 获取APP最新版本号, 可指定版本号,传入版本号'1.0.0'
Future<Map> getNewVersion([String version]) async {
  print('获取版本号......');
  Map resData = await safeRequest(
    servicePath['getVersion'],
    queryParameters: {'version': version},
  );

  return resData['data'] ?? {};
}

// 获取首页主题内容
Future getHomePageContent() async {
  print('开始获取首页数据......');
  return safeRequest(
    servicePath['homePageContent'],
    data: tokenData,
    options: Options(method: 'POST'),
  );
}

// 获取火爆专区方法
Future getHomePageBeloContent(Map page) async {
  print('获取火爆专区数据......');
  return safeRequest(
    servicePath['homePageBelowConten'],
    data: {...tokenData, ...page},
    options: Options(method: 'POST'),
  );
}

// 获取分类方法
Future getCategory() async {
  print('获取分类数据......');
  return safeRequest(
    servicePath['getCategory'],
    data: tokenData,
    options: Options(method: 'POST'),
  );
}

// 获取分类列表信息
Future getMallGoods(Map params) async {
  print('获取分类列表......');
  return safeRequest(
    servicePath['getMallGoods'],
    data: {...tokenData, ...params},
    options: Options(method: 'POST'),
  );
}

// 获取商品详情
Future getGoodDetailById(Map params) async {
  print('获取详情页......');
  return safeRequest(
    servicePath['getGoodDetailById'],
    data: {...tokenData, ...params},
    options: Options(method: 'POST'),
  );
}

// 搜索旅游数据
Future<SearchModel> getSearchCtrip(String searchKey) async {
  final data = await safeRequest(
    servicePath['searchUrl'] + searchKey,
  );
  print('获取搜索数据......');

  return SearchModel.fromJson(data);
}

/// 病毒研究情况以及全国疫情概览
/* 
变量名	注释
generalRemark	全国疫情信息概览
remarkX	注释内容，X为1~5
note1	病毒名称
note2	传染源
note3	传播途径
currentConfirmedCount(Incr)	现存确诊人数（较昨日增加数量）
值为confirmedCount(Incr) - curedCount(Incr) - deadCount(Incr)
confirmedCount(Incr)	累计确诊人数（较昨日增加数量）
suspectedCount(Incr)	疑似感染人数（较昨日增加数量）
curedCount(Incr)	治愈人数（较昨日增加数量）
deadCount(Incr)	死亡人数（较昨日增加数量）
seriousCount(Incr)	重症病例人数（较昨日增加数量）
updateTime	数据最后变动时间
 */
Future<NcvOverallModel> getNcvOverall() async {
  final data = await safeRequest(servicePath['ncvOverall']);

  return NcvOverallModel.fromJson(data);
}

/// 中国所有省份、地区或直辖市及世界其他国家的所有疫情信息变化的时间序列数据（精确到市），能够追溯确诊/疑似感染/治愈/死亡人数的时间序列。
/// [city] 查询的城市名称,例如 湖北省
///
/// [latest] 排序方式 1最新在前 0旧数据在前
/* 
示例
1. /nCoV/api/area?latest=1&province=湖北省
返回湖北省疫情最新数据


变量名	注释
locationId	城市编号
中国大陆城市编号为邮编，中国大陆以外城市编号暂不知规则
continent(English)Name	大洲（英文）名称
country(English)Name	国家（英文）名称
province(English)Name	省份、地区或直辖市（英文）全称
provinceShortName	省份、地区或直辖市简称
currentConfirmedCount	现存确诊人数，值为confirmedCount - curedCount - deadCount
confirmedCount	累计确诊人数
suspectedCount	疑似感染人数
curedCount	治愈人数
deadCount	死亡人数
comment	其他信息
cities	下属城市的情况
updateTime	数据更新时间
*/
Future<MyCityModel> getArea({String city, int latest = 1}) async {
  String _city = city.isEmpty ? "" : "&province=$city";
  final data = await safeRequest(
    servicePath['ncvArea'] + "?latest=$latest$_city",
  );
  return MyCityModel.fromJson(data);
}

/// 疫情有关的新闻信息，包含数据来源以及数据来源链接
/* 
示例
1. /nCoV/api/news?num=all
返回所有地区范围内全部新闻内容。

2. /nCoV/api/news?num=3&province=湖北省
返回湖北省范围内最新的3条新闻内容。

变量名	注释
pubDate	新闻发布时间
title	新闻标题
summary	新闻内容概述
infoSource	数据来源
sourceUrl	来源链接
province	省份或直辖市名称
provinceId	省份或直辖市代码
 */
Future getNcvNews({String newNum, String city}) async {
  String _newNum = newNum != null ? newNum : "all";
  String _city = city.isEmpty ? "" : "&province=$city";
  final data = await safeRequest(
    servicePath['ncvNews'] + "?num=$_newNum$_city",
  );

  return data;
}
