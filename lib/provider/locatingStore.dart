import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:baixing/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// 定位相关数据
class LocatingStore with ChangeNotifier {
  ReGeocode reGeocodeList; // 当前定位信息
  /// 城市名称
  String myCityName = '湖北省';

  /// 省份名称
  String myProvinceName = '武汉市';

  /// 更新定位位置
  Future getMyAddress() async {
    if (AppConfig.location) {
      LatLng myLatLng = await getMyLatLng();
      ReGeocode reGeocodeList = await AmapSearch.searchReGeocode(
        myLatLng, // 坐标 LatLng(38.98014190079781, 116.09168241501091)
        radius: 200.0, // 最大可找半径
      );
      // 获取地址
      myCityName = await reGeocodeList.cityName;
      myProvinceName = await reGeocodeList.provinceName;
    }
    if (myCityName?.isEmpty ?? false) {
      myCityName = '湖北省';
    }
    if (myProvinceName?.isEmpty ?? false) {
      myProvinceName = '武汉市';
    }
  }

  /// 更新数据视图
  locatingNotifyListeners() {
    notifyListeners();
  }

  /// 获取当前位置，返回Latlng类
  Future<LatLng> getMyLatLng() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    // 检查权限
    GeolocationStatus status =
        await geolocator.checkGeolocationPermissionStatus();
    if (status == GeolocationStatus.granted) {
      Position position = await geolocator.getLastKnownPosition();
      return LatLng(position?.latitude ?? 0, position?.longitude ?? 0);
    }
    // 没有检查时返回值
    return LatLng(0, 0);
  }
}
