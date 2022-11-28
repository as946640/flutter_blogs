import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class DetailHtml extends StatelessWidget {
  String html = '';
  DetailHtml({Key? key, this.html = ''}) : super(key: key);

  int count = 1;

  // 样式设置
  setHtmlStyle(element) {
    if (element.localName == 'tr') {
      count += 1;
    }
    if (element.localName == 'td' || element.localName == 'th') {
      return {
        'border': '1px solid #dfe2e5',
        'text-align': 'center',
        'min-height': '40px',
        'background-color': count % 2 == 0 ? '#f8f8f8' : '#fff',
      };
    }

    if (element.localName == 'table') {
      return {
        'border': '1px solid #dfe2e5',
        'border-collapse': 'collapse',
      };
    }

    // 设置 pading
    if (element.localName != 'pre') {
      return {
        'padding': '0px 14px',
      };
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      customStylesBuilder: ((element) => setHtmlStyle(element)),
      customWidgetBuilder: (element) {
        if (element.localName == 'code') {
          return SizedBox(
            width: 1.sw,
            child: SyntaxView(
              code: element.innerHtml, // Code text
              syntax: Syntax.JAVASCRIPT, // Language
              syntaxTheme: SyntaxTheme.gravityLight(), // Theme
              fontSize: 15.0, // Font size
              withZoom: false,
              withLinesCount: false,
              expanded: false,
            ),
          );
        }
        return null;
      },
    );
  }
}
