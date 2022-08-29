import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//링크값과 앱바title문구 보낸걸 받아서 웹뷰로 띄워주는 커스텀위젯임
class MyWebView extends StatelessWidget {
  MyWebView({Key? key, this.link, this.appbartext}) : super(key: key);
  final link;   //웹뷰 띄워줄 링크
  final appbartext;  //appbartitle로 사용될 문구

  //웹뷰의 뒤로가기버튼을 위한 컨트롤러객체
  //final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //웹뷰 뒤로가기나 백키를 위한작업
      child: Scaffold(
        appBar: AppBar(
          //뒤로가기버튼 색변경
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          title: Text(appbartext, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0.0,  //그림자 농도 설정임. 0넣어서 제거
        ),
        body: WebView(
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
          //뒤로가기버튼을위한것
          onWebViewCreated: (var webViewController){
            //_controller.complete(webViewController);
            _webViewController = webViewController;
          },
        ),
      ),
      onWillPop: (){
        var future = _webViewController.canGoBack();
        future.then((canGoBack) {
          if (canGoBack) {
            _webViewController.goBack();
          } else {
            Navigator.pop(context);
            print('더이상 뒤로갈페이지가 없습니다.');
          }
        });
        return Future.value(false);
      },
    );
  }
}


