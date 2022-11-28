import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blog/components/HomePage/ListItem.dart';
import 'package:flutter_blog/util/storage.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/api/serch/serch.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FocusNode focusNode = FocusNode();

  List history_srarch = [];

  Timer? timer;

  String searchText = '';

  List articleList = [];

  /// 搜索
  serchChange(value) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    if (value == '') return;

    timer = Timer(const Duration(milliseconds: 800), () {
      showLoading();
      value.trim();
      focusNode.unfocus();
      serchArticle(value).then((res) {
        searchText = value;
        articleList = res.data['posts'];
        hideLoading();

        /// 存储历史数据
        history_srarch.add(value);
        storeSetItem('history_srarch', history_srarch);

        setState(() {});
      }).catchError((err) {
        print(err);
        hideLoading();
      });
    });
  }

  /// 历史点击
  tagCLick(value) {
    showLoading();
    serchArticle(value).then((res) {
      articleList = res.data['posts'];
      hideLoading();

      setState(() {});
    }).catchError((err) {
      print(err);
      hideLoading();
    });
  }

  @override
  void initState() {
    super.initState();
    storeGetItem('history_srarch', special: true).then((value) {
      print(value);
      history_srarch = value ?? [];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: Column(
        children: [
          Container(
            height: 50.h + ScreenUtil().statusBarHeight,
            padding: EdgeInsets.only(
              top: ScreenUtil().statusBarHeight,
              left: 10.w,
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey.shade200,
            ))),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 34.h,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        isDense: true,
                        alignLabelWithHint: true,
                        hintText: '搜索博客文章',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14.sm,
                        ),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey.shade400,
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (value) => serchChange(value),
                      onSubmitted: (value) => serchChange(value),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('搜索'),
                )
              ],
            ),
          ),
          Visibility(
              visible: articleList.isEmpty,
              child: Container(
                  width: 1.sw,
                  margin: EdgeInsets.only(top: 10.h),
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      children: List.generate(history_srarch.length, (index) {
                        return Ink(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: () => tagCLick(history_srarch[index]),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 100,
                                maxHeight: 24.h,
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              child: Text(
                                history_srarch[index],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13.sm,
                                ),
                              ),
                            ),
                          ),
                        );
                      })))),
          Expanded(
            child: ListView.builder(
              itemCount: articleList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListItem(data: articleList[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
