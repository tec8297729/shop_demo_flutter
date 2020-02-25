import 'package:baixing/pages/nCoVPage/model/seriesData_model.dart';
import 'package:baixing/pages/nCoVPage/provider/nCoVPage.p.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

/// 图形报表
class ChartsLegend extends StatefulWidget {
  @override
  _ChartsLegendState createState() => _ChartsLegendState();
}

class _ChartsLegendState extends State<ChartsLegend> {
  NCoVPageStore nCoVPageStore;
  List<charts.Series<OrdinalSales, String>> seriesList = [];
  bool animate = true;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((v) {
    //   setState(() {
    //     seriesList = _createSampleData();
    //     animate = false;
    //   });
    // });
  }

  /// 初始化图形数据
  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    var _resData = nCoVPageStore.ncvOverallData;
    List<SeriesDataModel> seriesData = [
      SeriesDataModel(
        title: '确诊',
        color: charts.Color(r: 199, g: 66, b: 5),
        data: [
          OrdinalSales(
            nCoVPageStore?.oldDay,
            int.parse(_resData[0]['count']),
          ),
          OrdinalSales(
            nCoVPageStore?.newDay,
            int.parse(_resData[0]['count']) +
                int.parse(_resData[0]['oldDayCount']),
          ),
        ],
      ),
      SeriesDataModel(
        title: '疑似',
        color: charts.Color(r: 229, g: 127, b: 0),
        data: [
          OrdinalSales(
            nCoVPageStore?.oldDay,
            int.parse(_resData[1]['count']),
          ),
          OrdinalSales(
            nCoVPageStore?.newDay,
            int.parse(_resData[1]['count']) +
                int.parse(_resData[1]['oldDayCount']),
          ),
        ],
      ),
      SeriesDataModel(
        title: '重症',
        color: charts.Color(r: 23, g: 162, b: 184),
        data: [
          OrdinalSales(
            nCoVPageStore?.oldDay,
            int.parse(_resData[2]['count']),
          ),
          OrdinalSales(
            nCoVPageStore?.newDay,
            int.parse(_resData[2]['count']) +
                int.parse(_resData[2]['oldDayCount']),
          ),
        ],
      ),
      SeriesDataModel(
        title: '死亡',
        color: charts.Color(r: 97, g: 97, b: 97),
        data: [
          OrdinalSales(
            nCoVPageStore?.oldDay,
            int.parse(_resData[3]['count']),
          ),
          OrdinalSales(
            nCoVPageStore?.newDay,
            int.parse(_resData[3]['count']) +
                int.parse(_resData[3]['oldDayCount']),
          ),
        ],
      ),
      SeriesDataModel(
        title: '治愈',
        color: charts.Color(r: 0, g: 148, b: 98),
        data: [
          OrdinalSales(
            nCoVPageStore?.oldDay,
            int.parse(_resData[4]['count']),
          ),
          OrdinalSales(
            nCoVPageStore?.newDay,
            int.parse(_resData[4]['count']) +
                int.parse(_resData[4]['oldDayCount']),
          ),
        ],
      ),
    ];
    return [
      for (var i = 0; i < seriesData.length; i++)
        new charts.Series<OrdinalSales, String>(
          id: seriesData[i].title,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          colorFn: (OrdinalSales sales, _) => seriesData[i].color,
          data: seriesData[i].data, // 数据
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    nCoVPageStore = Provider.of<NCoVPageStore>(context);
    seriesList = _createSampleData();

    return Consumer<NCoVPageStore>(
      builder: (_, store, child) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          height: ScreenUtil().setHeight(300),
          child: charts.BarChart(
            seriesList, // 数据源
            animate: animate, // 是否动画
            barGroupingType: charts.BarGroupingType.grouped, // 数据展示方式
            // Add the legend behavior to the chart to turn on legends.
            // This example shows how to optionally show measure and provide a custom
            // formatter.
            behaviors: [
              new charts.SeriesLegend(
                // Positions for "start" and "end" will be left and right respectively
                // for widgets with a build context that has directionality ltr.
                // For rtl, "start" and "end" will be right and left respectively.
                // Since this example has directionality of ltr, the legend is
                // positioned on the right side of the chart.
                position: charts.BehaviorPosition.end,
                // By default, if the position of the chart is on the left or right of
                // the chart, [horizontalFirst] is set to false. This means that the
                // legend entries will grow as new rows first instead of a new column.
                horizontalFirst: false,
                // This defines the padding around each legend entry.
                cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                // Set show measures to true to display measures in series legend,
                // when the datum is selected.
                showMeasures: true,
                // Optionally provide a measure formatter to format the measure value.
                // If none is specified the value is formatted as a decimal.
                measureFormatter: (num value) {
                  return value == null ? '-' : '${value}人';
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
