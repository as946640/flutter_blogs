import 'package:flutter_blog/util/qiniu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_blog/util/storage.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/api/user/user.dart';

class UserModel extends GetxController {
  final user = RxMap<String, dynamic>({
    "user_nicename": "请先登录",
    "user_url":
        "https://profile-avatar.csdnimg.cn/ba5de8384098446db7bec7023bd8acb3_weixin_45192421.jpg!0",
    "posts_count": "0"
  });

  void getUserData(userId) async {
    try {
      showLoading();
      final result = await getUser(userId);
      user.value = result.data['data'];
      hideLoading();
    } catch (e) {
      hideLoading();
    }
  }

  final ImagePicker _picker = ImagePicker();

  /// 本地选择照片
  void chooseImg() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      Get.back();
      final result = await uploadImg(image.path);
      if (result['code'] == 200) {
        Map data = {'ID': user['ID'], 'user_url': result['url']};
        _updateUser(data);
      }
    } catch (e) {
      print(e);
      toast('您禁止了 app 打开相册');
    }
  }

  /// 自己拍照
  void photograph() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo == null) return;
      Get.back();
      final result = await uploadImg(photo.path);
      if (result['code'] == 200) {
        Map data = {'ID': user['ID'], 'user_url': result['url']};

        _updateUser(data);
      }
    } catch (e) {
      print(e);

      toast('您禁止了 app 获取相机权限');
    }
  }

  /// 更新用户信息
  void _updateUser(data) async {
    try {
      showLoading(status: '更新用户信息中···');
      final result = await updateUser(data);
      user['user_url'] = result.data['data']['url'];
      hideLoading();
    } catch (e) {
      print(e);
      toast('更新用户信息错误');
    }
  }

  @override
  void onInit() {
    super.onInit();

    storeGetItem('user_info', special: true).then((res) {
      if (res is Map) {
        getUserData(res['ID']);
      }
    });
  }
}
