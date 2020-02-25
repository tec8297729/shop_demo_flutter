import 'package:baixing/pages/nCoVPage/components/ChartsLegend.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// 图表数据结构
class SeriesDataModel {
  String title;
  charts.Color color;
  List<OrdinalSales> data;

  SeriesDataModel({this.title, this.color, this.data});
}
