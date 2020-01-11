import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dioErrorUtil.dart';

Future<T> safeRequest<T>(String url, {Object data, Options options}) async {
  try {
    BaseOptions baseOpts = new BaseOptions(
      // baseUrl: 'http://v.jspang.com:8088/baixing/', // 请求前缀url
      // connectTimeout: 5000, // 连接服务器超时时间，单位是毫秒
      // receiveTimeout: 3000, // 接收数据的最长时限
      responseType: ResponseType.plain, // 数据类型
      contentType: 'application/x-www-form-urlencoded',
      // cookies: Iterable.empty(), // 可以添加一些公共cookie
      // maxRedirects: 2, // 重定向最大次数。
      // 当响应状态码不是成功状态(如404)时，是否接收响应内容，如果是false,则response.data将会为null
      receiveDataWhenStatusError: true,
    );

    Dio dioClient = new Dio(baseOpts); // 实例化请求，可以传入options参数
    final adapter = dioClient.httpClientAdapter as DefaultHttpClientAdapter;
    adapter.onHttpClientCreate = (client) {
      // 设置http请求代理
      // client.findProxy = (uri) {
      //   // 把所有url请求链接一起代理到指定IP地址
      //   return "PROXY http://192.168.124.94:8888";
      // };
      // 验证证书，返回true者验证通过
      client.badCertificateCallback = (cert, host, port) => true;
    };

    dioClient.interceptors.add(InterceptorsWrapper(
      // 请求拦截
      onRequest: (RequestOptions options) async {
        return options; //continue
      },
      // 响应拦截
      onResponse: (Response response) async {
        return response; // continue
      },
      // 当请求失败时做一些预处理
      onError: (DioError e) async {
        throw HttpException(DioErrorUtil.handleError(e));
        // return DioErrorUtil.handleError(e);
      },
    ));

    return dioClient
        .request(
          url,
          data: data,
          options: options,
        )
        .then((data) => jsonDecode(data.data));
  } catch (e) {
    throw e;
  }
}
