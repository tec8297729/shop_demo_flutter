class MyCityModel {
  List<Results> results;
  bool success;

  MyCityModel({this.results, this.success});

  MyCityModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Results {
  int locationId;
  String continentName;
  String continentEnglishName;
  String countryName;
  String countryEnglishName;
  String provinceName;
  String provinceShortName;
  String provinceEnglishName;
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  List<Cities> cities;
  String comment;
  int updateTime;

  Results(
      {this.locationId,
      this.continentName,
      this.continentEnglishName,
      this.countryName,
      this.countryEnglishName,
      this.provinceName,
      this.provinceShortName,
      this.provinceEnglishName,
      this.currentConfirmedCount,
      this.confirmedCount,
      this.suspectedCount,
      this.curedCount,
      this.deadCount,
      this.cities,
      this.comment,
      this.updateTime});

  Results.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    continentName = json['continentName'];
    continentEnglishName = json['continentEnglishName'];
    countryName = json['countryName'];
    countryEnglishName = json['countryEnglishName'];
    provinceName = json['provinceName'];
    provinceShortName = json['provinceShortName'];
    provinceEnglishName = json['provinceEnglishName'];
    currentConfirmedCount = json['currentConfirmedCount'];
    confirmedCount = json['confirmedCount'];
    suspectedCount = json['suspectedCount'];
    curedCount = json['curedCount'];
    deadCount = json['deadCount'];
    if (json['cities'] != null) {
      cities = new List<Cities>();
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
    comment = json['comment'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationId'] = this.locationId;
    data['continentName'] = this.continentName;
    data['continentEnglishName'] = this.continentEnglishName;
    data['countryName'] = this.countryName;
    data['countryEnglishName'] = this.countryEnglishName;
    data['provinceName'] = this.provinceName;
    data['provinceShortName'] = this.provinceShortName;
    data['provinceEnglishName'] = this.provinceEnglishName;
    data['currentConfirmedCount'] = this.currentConfirmedCount;
    data['confirmedCount'] = this.confirmedCount;
    data['suspectedCount'] = this.suspectedCount;
    data['curedCount'] = this.curedCount;
    data['deadCount'] = this.deadCount;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    data['comment'] = this.comment;
    data['updateTime'] = this.updateTime;
    return data;
  }
}

class Cities {
  String cityName;
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  int locationId;
  String cityEnglishName;

  Cities(
      {this.cityName,
      this.currentConfirmedCount,
      this.confirmedCount,
      this.suspectedCount,
      this.curedCount,
      this.deadCount,
      this.locationId,
      this.cityEnglishName});

  Cities.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    currentConfirmedCount = json['currentConfirmedCount'];
    confirmedCount = json['confirmedCount'];
    suspectedCount = json['suspectedCount'];
    curedCount = json['curedCount'];
    deadCount = json['deadCount'];
    locationId = json['locationId'];
    cityEnglishName = json['cityEnglishName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['currentConfirmedCount'] = this.currentConfirmedCount;
    data['confirmedCount'] = this.confirmedCount;
    data['suspectedCount'] = this.suspectedCount;
    data['curedCount'] = this.curedCount;
    data['deadCount'] = this.deadCount;
    data['locationId'] = this.locationId;
    data['cityEnglishName'] = this.cityEnglishName;
    return data;
  }
}
