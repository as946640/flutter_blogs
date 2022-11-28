import 'package:flutter/material.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_blog/model/userModel/userModel.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class User extends StatelessWidget {
  User({Key? key}) : super(key: key);

  final userModel = Get.put(UserModel());

  void toLogin() {
    Get.toNamed('/login');
  }

  /// 相机点击
  void menuLeftClick() {
    Get.bottomSheet(PopMenuList());
  }

  /// 设置
  void menuReftClick() {
    if (userModel.user['user_nicename'] == '请先登录') {
      Get.toNamed('/login');
      toast('请先登录');
      return;
    }
    Get.toNamed('/setting', arguments: userModel.user);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Container(
        height: 1.sh,
        padding: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
          top: ScreenUtil().statusBarHeight,
        ),
        color: Colors.grey.shade100,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    onPressed: () => menuLeftClick(),
                    icon: const Icon(Icons.camera_alt_rounded),
                  ),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    onPressed: () => menuReftClick(),
                    icon: const Icon(Icons.settings),
                  ),
                ),
              ],
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => menuLeftClick(),
                      child: ClipOval(
                        child: Image.network(
                          userModel.user['user_url'].toString(),
                          width: 60.r,
                          height: 60.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: userModel.user['user_nicename'].toString() ==
                                    '请先登录'
                                ? () => toLogin()
                                : null,
                            child: Text(
                              userModel.user['user_nicename'].toString(),
                              style: TextStyle(
                                fontSize: 28.sm,
                              ),
                            ),
                          ),
                          Text(
                            '查看或者编辑资料',
                            style: TextStyle(
                              fontSize: 12.sm,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  left: 30.w,
                  right: 30.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          userModel.user['posts_count'].toString(),
                          style: TextStyle(
                            fontSize: 20.sm,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '文章量',
                          style: TextStyle(
                            fontSize: 12.sm,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '123',
                          style: TextStyle(
                            fontSize: 20.sm,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '收藏量',
                          style: TextStyle(
                            fontSize: 12.sm,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '22',
                          style: TextStyle(
                            fontSize: 20.sm,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '点赞量',
                          style: TextStyle(
                            fontSize: 12.sm,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 40.h,
                left: 10.w,
                right: 10.w,
              ),
              child: CellList(),
            )
          ],
        ),
      ),
    );
  }
}

class CellList extends StatelessWidget {
  CellList({Key? key}) : super(key: key);

  List cells = [
    {
      'title': "点赞的帖子",
      'icon': IconFont(
        IconNames.dianzanweixuanzhong,
        size: 18.sm,
      ),
      'id': 1
    },
    {
      'title': "收藏的帖子",
      'icon': IconFont(
        IconNames.shoucang,
        size: 20.sm,
      ),
      'id': 2
    },
    {
      'title': "评论的帖子",
      'icon': IconFont(
        IconNames.xiaoxi_1,
        size: 20.sm,
      ),
      'id': 3
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: cells.map((e) {
          return Ink(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Get.toNamed('/relevant?index=${e['id']}&title=${e['title']}');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 14.h,
                ),
                child: Row(
                  children: [
                    e['icon'],
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        e['title'],
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    const Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// 顶部菜单

class PopMenuList extends StatelessWidget {
  PopMenuList({Key? key}) : super(key: key);

  UserModel userModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 200.h,
      padding: EdgeInsets.only(
        top: 20.h,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text(
            '更换用户头像',
            style: TextStyle(
              fontSize: 16.sm,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          Material(
            child: Ink(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.h),
              child: InkWell(
                onTap: () => userModel.chooseImg(),
                child: Container(
                  width: 1.sw,
                  height: 46.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey.shade100.withOpacity(0.7),
                      ),
                    ),
                  ),
                  child: const Text('相册选择'),
                ),
              ),
            ),
          ),
          Material(
            child: Ink(
              color: Colors.white,
              child: InkWell(
                onTap: () => userModel.photograph(),
                child: Container(
                  width: 1.sw,
                  height: 46.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey.shade100.withOpacity(0.7),
                      ),
                    ),
                  ),
                  child: const Text('手机拍照'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
