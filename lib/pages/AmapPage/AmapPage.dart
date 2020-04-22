import 'dart:math';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:baixing/routes/routeName.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class AmapPage extends StatefulWidget {
  @override
  _AmapPageState createState() => _AmapPageState();
}

class _AmapPageState extends State<AmapPage> {
  LatLng myLatLng = LatLng(39, 116);

  // 标记
  List<MarkerOption> markerOption = [
    MarkerOption(
      latLng: LatLng(38.85119558013417, 115.90371857488084),
      title: '起标位置一',
      anchorU: 120,
      anchorV: 1110,
    ),
    MarkerOption(
      latLng: LatLng(38.946156771732724, 116.81127214273855),
      title: '起标位置2',
      anchorU: 20, // 横轴锚点
      anchorV: 100, // 纵轴锚点
    ),
    MarkerOption(
      latLng: LatLng(38.98014190079781, 116.09168241501091),
      title: '雄县位置',
      anchorU: 20, // 横轴锚点
      anchorV: 100, // 纵轴锚点
      draggable: true, // 是否可以拖动
      infoWindowEnabled: false, // 是否可以弹窗口显示标题
    ),
  ];

  AmapController _controller; // 地图控制器，地图绘制完成函数中获取的
  List<Marker> _markers = [];
  List<LatLng> _latLngList = [
    LatLng(38.85119558013417, 115.90371857488084),
    LatLng(38.946156771732724, 116.81127214273855),
    LatLng(38.98014190079781, 116.09168241501091),
  ];
  int city = 0;

  @override
  void initState() {
    super.initState();
    initMap();
  }

  // 初始化地图参数,在页面组件加载时调用
  initMap() async {
    await AmapService.init(
      iosKey: '7a04506d15fdb7585707f7091d715ef4',
      androidKey: 'd0739f38b5ccfbc22b274a00734b90af',
    );
    // 如果你觉得引擎的日志太多, 可以关闭Fluttify引擎的日志
    await enableFluttifyLog(false); // 关闭log
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('绘制点标记')),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: mapWidget(), // 地图
          ),

          ///获取当前经纬度
          ListTile(
            title: Center(child: Text('调试经纬度')),
            onTap: () {
              Navigator.pushNamed(context, RouteName.searchGeocodePage);
            },
          ),

          ///定位显示图标
          ListTile(
            title: Center(child: Text('添加Marker')),
            onTap: _showLatLng,
          ),

          ///连线
          ListTile(
            title: Center(child: Text('添加线')),
            onTap: () async {
              // 添加折线,
              await _controller?.addPolyline(
                PolylineOption(
                  width: 10, // 连接线宽度
                  strokeColor: Colors.green, // 线的颜色
                  // 按顺序进行一对一对应连接线
                  latLngList: _latLngList,
                ),
              );
            },
          ),
          ListTile(
            title: Center(child: Text('删除Marker')),
            onTap: () async {
              if (_markers.isNotEmpty) {
                await _markers[0].remove(); // 调用地图内置方法移除
                _markers.removeAt(0); // 移除当前数组
              }
            },
          ),
          ListTile(
            title: Center(child: Text('清除所有Marker')),
            onTap: () async {
              await _controller.clearMarkers(); // 清空所有标点
            },
          ),
        ],
      ),
    );
  }

  /// 高德地图组件
  Widget mapWidget() {
    return AmapView(
      mapType: MapType.Standard, // 地图类型
      zoomLevel: 10, // 缩放级别
      showZoomControl: true, // 是否显示缩放控件
      showCompass: true, // 是否显示指南针控件
      showScaleControl: true, // 是否显示比例尺控件
      zoomGesturesEnabled: true, // 是否使能缩放手势
      scrollGesturesEnabled: true, // 是否使能滚动手势
      rotateGestureEnabled: true, // 是否使能旋转手势
      tiltGestureEnabled: true, // 是否使能倾斜手势
      centerCoordinate: myLatLng, // 中心点坐标

      // 标记
      markers: markerOption,
      // 标识点击回调
      // onMarkerClicked: (Marker marker) {},

      // 地图点击回调
      onMapClicked: (LatLng coord) async {
        print(coord);

        /// 获取行政区划数据
        // final district = await AmapSearch.searchDistrict('江西省南昌市');
        // final list = await district.districtList;
        // print(list);
      },
      // 地图创建完成回调
      onMapCreated: (controller) async {
        _controller = controller;
        if (await requestPermission()) {
          print('有权限，定位my中心点');
          await controller
              .showMyLocation(MyLocationOption(show: true)); // 显示自己当前GPS位置为中心点
        }
      },
    );
  }

  Future<bool> requestPermission() async {
    final permissions = await PermissionHandler()
        .requestPermissions([PermissionGroup.location]);

    if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
      return true;
    } else {
      Fluttertoast.showToast(
        msg: '没有定位权限',
        timeInSecForIos: 3,
        gravity: ToastGravity.CENTER, // 提示位置，CENTER居中
      );
      return false;
    }
  }

  ///展示定位点
  _showLatLng() async {
    final random = Random();
    _controller.getLocation().then((_) {
      //获取随机定位点
      LatLng latLng = LatLng(
        _.latitude + (random.nextDouble() / 10),
        _.longitude + (random.nextDouble() / 10),
      );

      _latLngList.add(latLng);
      print('---获取的定位点------ ${_.toString()}');
      _getLatLng(latLng);
    });
  }

  ///地图标记点
  _getLatLng(LatLng latLng) async {
    city = city + 1;
    final marker = await _controller?.addMarker(
      MarkerOption(
        latLng: latLng,
        title: '北京 $city',
        snippet: '描述',
        // iconUri: _assetsIcon,
        draggable: true,
      ),
    );
    _markers.add(marker);
  }
}
