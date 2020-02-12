/// Example of a stacked area chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.seriesList, {this.animate});

  /// 通过调用此方法完成组件调用
  factory StackedAreaLineChart.withSampleData() {
    return new StackedAreaLineChart(
      _createSampleData(), // 拼接数据,演示为写死数据
      animate: false, // 是否显示动画过渡
    );
  }

  @override
  Widget build(BuildContext context) {
    // 标签样式
    charts.TextStyleSpec _textStyle = charts.TextStyleSpec(
      //可对x轴设置颜色等
      color: charts.Color(r: 0x4C, g: 0xAF, b: 0x50),
      fontSize: 22,
    );

    final ticksX = charts.StaticNumericTickProviderSpec([
      charts.TickSpec<num>(
        0, // 区间值,在定义数据源中第一个参数
        label: '', // 显示的标签文字
        style: _textStyle, // 标签样式
      ),
      charts.TickSpec<num>(10, label: '', style: _textStyle),
      charts.TickSpec<num>(20, label: '', style: _textStyle),
      charts.TickSpec<num>(30, label: '', style: _textStyle),
    ]);
    final ticksY = charts.StaticNumericTickProviderSpec([
      charts.TickSpec<num>(0, label: '', style: _textStyle),
    ]);

    return charts.LineChart(
      seriesList, // 数据源
      defaultRenderer: charts.LineRendererConfig(
        includeArea: true,
        stacked: true,
        roundEndCaps: true,
      ),
      animate: animate, // 是否动画
      // 使用自定义轴数据显示,对应的类介绍
      /* 
        BarChart类 使用数据类OrdinalAxisSpec,里面用StaticOrdinalTickProviderSpec
        LineChart类 使用数据类NumericAxisSpec,里面用StaticNumericTickProviderSpec
        数据类自定义通用方法 AxisSpec<类型>
      */
      // 自定义x轴标签内容, 创建的是什么图表形内置的就用相应类型(LineChart图表)
      domainAxis: new charts.NumericAxisSpec(tickProviderSpec: ticksX),
      // 自定义y轴标签显示内容
      primaryMeasureAxis: charts.NumericAxisSpec(tickProviderSpec: ticksY),
      selectionModels: [
        new charts.SelectionModelConfig(
          type: charts.SelectionModelType.action,
          // 获取图表点击后的数据
          changedListener: (model) {
            // print('${model.selectedDatum}');
          },
        ),
      ],
    );
  }

  /// 把数据组装成 charts 支持的格式
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final myFakeDesktopData = [
      new LinearSales(0, 0),
      new LinearSales(4, 4),
      new LinearSales(9, 21),
      new LinearSales(10, 22),
      new LinearSales(11, 21),
      new LinearSales(13, 20),
      new LinearSales(16, 4),
      new LinearSales(18, 1),
      new LinearSales(20, 0),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop', // 单个数据系统的唯一标识符，用来呈现多个系列的图表
        // 用来定义当前数据的柱状图颜色
        colorFn: (_, __) => charts.Color(r: 255, g: 255, b: 255),
        // 线内部区域背景颜色
        areaColorFn: (_, __) => charts.Color(r: 216, g: 239, b: 253),
        // 表示需要观测的事物，比如'店铺'
        domainFn: (LinearSales sales, _) => sales.x,
        // 用来表示数据，比如'店铺的销售额'
        measureFn: (LinearSales sales, _) => sales.y,
        data: myFakeDesktopData, // 数据源
        overlaySeries: true, // 不显示点击后的默认样式
      ),
    ];
  }
}

/// 图表数据类型
class LinearSales {
  final int x;
  final int y;

  LinearSales(this.x, this.y);
}
