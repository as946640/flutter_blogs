import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Reply extends StatelessWidget {
  String commentValue = '';
  final parent;
  ArticleModel articleModel = Get.find();

  Reply({
    Key? key,
    required this.parent,
  }) : super(key: key);

  /// 评论
  void _comment() {
    if (commentValue.isEmail) return;

    Map data = {
      "content": commentValue,
      "author": '1',
      "author_name": "asen",
      "author_email": "2360072651@qq.com",
      "parent": parent
    };
    articleModel.articleComment(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.h,
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                maxLength: 1000,
                minLines: 3,
                maxLines: 5,
                textInputAction: TextInputAction.done,
                onChanged: (String value) {
                  commentValue = value;
                },
                decoration: InputDecoration(
                  hintText: '快来发表评论吧 ~',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _comment();
                    },
                    child: const Text(
                      '发送',
                      style: TextStyle(
                        color: Color(0xff81888d),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade300),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
