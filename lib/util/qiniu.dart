import 'dart:io';

import 'package:flutter_blog/api/user/user.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

/// 七牛云 图片上传
Future<Map> uploadImg(String filePath) async {
  try {
    showLoading(status: '图片上传中');
    final token = await getQiniuToken();
    final storage = Storage();
    final result = await storage.putFile(
      File(filePath),
      token!,
    );
    hideLoading();

    return {
      'code': 200,
      'url': "http://rbyvgd6d9.hn-bkt.clouddn.com/${result.key}",
    };
  } catch (e) {
    return {
      'code': 500,
      'url': '',
    };
  }
}
