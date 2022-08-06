import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


//웹뷰 띄워주는 위젯 만듬
class MyWebView extends StatefulWidget {
  const MyWebView({Key? key}) : super(key: key);

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {

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
          title: Text('웹뷰', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,  //그림자 농도 설정임. 0넣어서 제거
        ),
        body: WebView(
          initialUrl: "https://m.naver.com",
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

