import 'package:flutter_blog/util/dio_util/dio_method.dart';
import 'package:flutter_blog/util/dio_util/dio_util.dart';

///  用户数据
Future getUser(id) {
  return DioUtil()
      .request('/wp-json/myplugin/v1/user?id=1', params: {'id': id});
}

///  获取验证码
Future getCode(phone) {
  return DioUtil().request('/wp-json/myplugin/v1/code?phone=$phone');
}

/// 校验验证码
Future checkCode(data) {
  return DioUtil().request(
    '/wp-json/myplugin/v1/checkCode',
    method: DioMethod.post,
    data: data,
  );
}

/// 手机号登录 || 注册 注册之后直接登录
Future login(phone) {
  return DioUtil().request(
    '/wp-json/myplugin/v1/phoneLogin',
    method: DioMethod.post,
    data: {'phone': phone},
  );
}

///  获取七牛云 token
Future<String?> getQiniuToken() async {
  try {
    final result = await DioUtil().request('/wp-json/myplugin/v1/uploadToken');
    print(result);
    return result.data['data']['unload_token'];
  } catch (e) {
    print(e);
    return null;
  }
}

/// 更新用户信息
Future updateUser(data) {
  return DioUtil().request(
    '/wp-json/myplugin/v1/user',
    method: DioMethod.put,
    data: data,
  );
}
