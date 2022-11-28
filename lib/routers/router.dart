import 'package:flutter/material.dart';
import 'package:flutter_blog/pages/comment/comment.dart';
import 'package:flutter_blog/pages/detail/detail.dart';
import 'package:flutter_blog/pages/login/login.dart';
import 'package:flutter_blog/pages/relevant/relevant.dart';
import 'package:flutter_blog/pages/setting/setting.dart';
import 'package:flutter_blog/pages/tab/tab.dart';
import 'package:flutter_blog/pages/verificationCode/verificationCode.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> router = [
  GetPage(name: '/', page: () => HomeTab()),
  GetPage(name: '/login', page: () => Login()),
  GetPage(name: '/detailds', page: () => ArticleDetail()),
  GetPage(
    name: '/code',
    page: () => verificationCode(),
    transition: Transition.rightToLeft,
  ),
  GetPage(name: '/comment', page: () => CommentPage()),
  GetPage(
    name: '/relevant',
    page: () => Relevant(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/setting',
    page: () => Setting(),
    transition: Transition.rightToLeft,
  ),
];
