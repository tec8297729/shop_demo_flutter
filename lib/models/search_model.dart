/// 搜索模型
class SearchModel {
  Head head;
  List<SearchItem> data;

  SearchModel({this.head, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    head = json['head'] != null ? new Head.fromJson(json['head']) : null;
    if (json['data'] != null) {
      data = new List<SearchItem>();
      json['data'].forEach((v) {
        data.add(new SearchItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.head != null) {
      data['head'] = this.head.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Head {
  Null auth;
  String errcode;

  Head({this.auth, this.errcode});

  Head.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    errcode = json['errcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth'] = this.auth;
    data['errcode'] = this.errcode;
    return data;
  }
}

class SearchItem {
  String code;

  /// 酒店
  String word;

  /// hotel
  String type;

  /// 上海
  String districtname;

  /// 链接
  String url;

  /// 实时计价
  String price;

  /// 虹桥
  String zonename;

  /// 豪华型
  String star;

  SearchItem(
      {this.code,
      this.word,
      this.type,
      this.districtname,
      this.url,
      this.price,
      this.zonename,
      this.star});

  SearchItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    word = json['word'];
    type = json['type'];
    districtname = json['districtname'];
    url = json['url'];
    price = json['price'];
    zonename = json['zonename'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['word'] = this.word;
    data['type'] = this.type;
    data['districtname'] = this.districtname;
    data['url'] = this.url;
    data['price'] = this.price;
    data['zonename'] = this.zonename;
    data['star'] = this.star;
    return data;
  }
}
