import 'package:dio/dio.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'dio_response.dart';
import 'package:get/get.dart' as _get;

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 对非open的接口的请求参数全部增加userId
    if (!options.path.contains("open")) {
      // options.queryParameters["userId"] = "xxx";
    }

    // 头部添加token
    options.headers["authorization"] = "Basic YXNlbjphczEyMzEyMw==";

    // 更多业务需求

    handler.next(options);

    // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print(response);

    // 请求成功是对数据做基本处理
    if (response.statusCode == 200) {
      response.data =
          DioResponse(code: 0, message: "请求成功啦", data: response.data);
    } else {
      response.data =
          DioResponse(code: 1, message: "请求失败啦", data: response.data);
    }

    // 对某些单独的url返回数据做特殊处理
    if (response.requestOptions.baseUrl.contains("???????")) {
      //....
    }

    // 根据公司的业务需求进行定制化处理

    // 重点
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      // 连接服务器超时
      case DioErrorType.connectTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 响应超时
      case DioErrorType.receiveTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 发送超时
      case DioErrorType.sendTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 请求取消
      case DioErrorType.cancel:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 404/503错误
      case DioErrorType.response:
        {
          final msg = err.response?.data['message'] ?? '请求错误';

          toast(msg);

          if (err.response?.statusCode == 403) {
            _get.Get.toNamed('/login');
          }
        }
        break;
      // other 其他错误类型
      case DioErrorType.other:
        {}
        break;
    }
    super.onError(err, handler);
  }
}
