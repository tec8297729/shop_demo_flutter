const serviceUrl = 'http://v.jspang.com:8088/baixing/';
// const serviceUrl =
//     'https://www.fastmock.site/mock/4fa6906a0c87f7c2513e85cb98eb4bdb/shop/';
const servicePath = {
  'homePageContent': '${serviceUrl}wxmini/homePageContent', //商店首页信息
  'homePageBelowConten': '${serviceUrl}wxmini/homePageBelowConten', //商城首页热卖商品
  'getCategory': '${serviceUrl}wxmini/getCategory', //商品类别信息
  'getMallGoods': '${serviceUrl}wxmini/getMallGoods', //商品分类的商品列表
  'getGoodDetailById': '${serviceUrl}wxmini/getGoodDetailById', //商品详细信息
  'searchUrl':
      'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=', // 搜索旅游数据
};
// const servicePath = {
//   'homePageContent': 'wxmini/homePageContent', //商店首页信息
//   'homePageBelowConten': 'wxmini/homePageBelowConten', //商城首页热卖商品
//   'getCategory': 'wxmini/getCategory', //商品类别信息
//   'getMallGoods': 'wxmini/getMallGoods', //商品分类的商品列表
//   'getGoodDetailById': 'wxmini/getGoodDetailById', //商品详细信息
//   'searchUrl':
//       'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=', // 搜索旅游数据
// };
