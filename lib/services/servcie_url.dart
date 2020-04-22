// const serviceUrl = 'http://v.jspang.com:8088/baixing/';
var serviceUrl =
    'https://www.fastmock.site/mock/4fa6906a0c87f7c2513e85cb98eb4bdb/shop/';
var nCoVUrl = nCoVUrl3;
// mock接口
const nCoVUrl2 =
    'https://www.fastmock.site/mock/4fa6906a0c87f7c2513e85cb98eb4bdb/shop/nCoV/api/';
// 公开api接口，第三方git提供
const nCoVUrl3 = 'https://lab.isaaclin.cn/nCoV/api/';

var servicePath = {
  'homePageContent': '${serviceUrl}wxmini/homePageContent', //商店首页信息
  'homePageBelowConten': '${serviceUrl}wxmini/homePageBelowConten', //商城首页热卖商品
  'getCategory': '${serviceUrl}wxmini/getCategory', //商品类别信息
  'getMallGoods': '${serviceUrl}wxmini/getMallGoods', //商品分类的商品列表
  'getGoodDetailById': '${serviceUrl}wxmini/getGoodDetailById', //商品详细信息
  // 搜索旅游数据
  'searchUrl':
      'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=',
  // 最新版本号
  'getVersion':
      'https://www.fastmock.site/mock/4fa6906a0c87f7c2513e85cb98eb4bdb/shop/appVersion',

  /// 病毒研究情况以及全国疫情概览
  'ncvOverall': '${nCoVUrl}overall',

  /// 病毒省份、地区、直辖市列表
  'ncvProvinceName': '${nCoVUrl}provinceName',

  /// 中国所有省份、地区或直辖市及世界其他国家的所有疫情信息变化的时间序列数据（精确到市），能够追溯确诊/疑似感染/治愈/死亡人数的时间序列。
  'ncvArea': '${nCoVUrl}area',

  /// 所有与疫情有关的新闻信息
  'ncvNews': '${nCoVUrl}news',

  /// 疫情有关的谣言以及丁香园的辟谣
  'ncvRumors': '${nCoVUrl}rumors',
};
