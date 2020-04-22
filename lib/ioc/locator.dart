import 'package:get_it/get_it.dart';
import 'services/common_service.dart';

// 统一导出管理
export 'services/common_service.dart' show CommonService;

GetIt locator = GetIt.instance; // 创建容器实例
// 挂载所有容器的函数
void setupLocator() {
  locator.registerLazySingleton<CommonService>(() => CommonService());
}
