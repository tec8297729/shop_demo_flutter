class NcvOverallModel {
  List<Results> results;
  bool success;

  NcvOverallModel({this.results, this.success});

  NcvOverallModel.fromJson(Map<String, dynamic> json) {
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
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  int seriousCount;
  int currentConfirmedIncr;
  int confirmedIncr;
  int suspectedIncr;
  int curedIncr;
  int deadIncr;
  int seriousIncr;
  String generalRemark;
  String abroadRemark;
  String remark1;
  String remark2;
  String remark3;
  String remark4;
  String remark5;
  String note1;
  String note2;
  String note3;
  int updateTime;

  Results(
      {this.currentConfirmedCount,
      this.confirmedCount,
      this.suspectedCount,
      this.curedCount,
      this.deadCount,
      this.seriousCount,
      this.currentConfirmedIncr,
      this.confirmedIncr,
      this.suspectedIncr,
      this.curedIncr,
      this.deadIncr,
      this.seriousIncr,
      this.generalRemark,
      this.abroadRemark,
      this.remark1,
      this.remark2,
      this.remark3,
      this.remark4,
      this.remark5,
      this.note1,
      this.note2,
      this.note3,
      this.updateTime});

  Results.fromJson(Map<String, dynamic> json) {
    currentConfirmedCount = json['currentConfirmedCount'];
    confirmedCount = json['confirmedCount'];
    suspectedCount = json['suspectedCount'];
    curedCount = json['curedCount'];
    deadCount = json['deadCount'];
    seriousCount = json['seriousCount'];
    currentConfirmedIncr = json['currentConfirmedIncr'];
    confirmedIncr = json['confirmedIncr'];
    suspectedIncr = json['suspectedIncr'];
    curedIncr = json['curedIncr'];
    deadIncr = json['deadIncr'];
    seriousIncr = json['seriousIncr'];
    generalRemark = json['generalRemark'];
    abroadRemark = json['abroadRemark'];
    remark1 = json['remark1'];
    remark2 = json['remark2'];
    remark3 = json['remark3'];
    remark4 = json['remark4'];
    remark5 = json['remark5'];
    note1 = json['note1'];
    note2 = json['note2'];
    note3 = json['note3'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentConfirmedCount'] = this.currentConfirmedCount;
    data['confirmedCount'] = this.confirmedCount;
    data['suspectedCount'] = this.suspectedCount;
    data['curedCount'] = this.curedCount;
    data['deadCount'] = this.deadCount;
    data['seriousCount'] = this.seriousCount;
    data['currentConfirmedIncr'] = this.currentConfirmedIncr;
    data['confirmedIncr'] = this.confirmedIncr;
    data['suspectedIncr'] = this.suspectedIncr;
    data['curedIncr'] = this.curedIncr;
    data['deadIncr'] = this.deadIncr;
    data['seriousIncr'] = this.seriousIncr;
    data['generalRemark'] = this.generalRemark;
    data['abroadRemark'] = this.abroadRemark;
    data['remark1'] = this.remark1;
    data['remark2'] = this.remark2;
    data['remark3'] = this.remark3;
    data['remark4'] = this.remark4;
    data['remark5'] = this.remark5;
    data['note1'] = this.note1;
    data['note2'] = this.note2;
    data['note3'] = this.note3;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
