import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/model/setting/setting.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);

  final settingModel = Get.put(SettingModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          color: Colors.black54,
        ),
        title: const Text(
          '信息修改',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SettingForm(),
            Container(
              width: 1.sw,
              margin: EdgeInsets.only(top: 40.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ElevatedButton(
                onPressed: () => settingModel.submit(),
                child: const Text('修改用户信息'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(4),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingForm extends StatelessWidget {
  SettingForm({Key? key}) : super(key: key);

  SettingModel settingModel = Get.find();

  _buildButton() {
    return Obx(
      () => ElevatedButton(
        onPressed: () => settingModel.getCodes(),
        child: Text(settingModel.timeIndex < 60
            ? '${settingModel.timeIndex}后获取验证码'
            : '获取验证码'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: settingModel.formKey,
      child: Column(
        children: [
          Container(
            width: 1.sw,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 60.w,
                  child: const Text('名称'),
                ),
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    initialValue: settingModel.user['user_nicename'],
                    onSaved: (value) {
                      if (value == null) return;
                      settingModel.user['user_nicename'] = value;
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 1.sw,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 60.w, child: const Text('手机号')),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLength: 11,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: '请输入新手机号',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: settingModel.user['phone'],
                        onChanged: (value) {
                          settingModel.user['phone'] = value;
                        },
                      ),
                    ),
                    _buildButton()
                  ],
                ))
              ],
            ),
          ),
          Container(
            width: 1.sw,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 60.w, child: const Text('验证码')),
                Expanded(
                    child: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: '请输入验证码',
                    border: InputBorder.none,
                  ),
                  onChanged: settingModel.codeChange,
                ))
              ],
            ),
          ),
          Container(
            width: 1.sw,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 60.w, child: const Text('邮箱号')),
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    initialValue: settingModel.user['user_email'],
                    onSaved: (value) {
                      if (value == null) return;
                      settingModel.user['user_email'] = value;
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
