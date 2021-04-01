//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
//      class WebviewPage extends StatefulWidget {
//       var downloadedUrl;
//       WebviewPage({this.downloadedUrl});
//        @override
//        _WebviewPageState createState() => _WebviewPageState();
//      }
//
//      class _WebviewPageState extends State<WebviewPage> {
//        @override
//        Widget build(BuildContext context) {
//          double width = MediaQuery.of(context).size.width;
//          double height = MediaQuery.of(context).size.height;
//          return Scaffold(
//            backgroundColor: Colors.white,
//            body: SafeArea(
//              child:WebView(
//                initialUrl: widget.downloadedUrl,
//                javascriptMode: JavascriptMode.unrestricted,
//              )
//            ),
//          );
//        }
//       }
//
