import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  String? url;
  String? title;
  WebViewScreen(this.title, this.url, {super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((title !=null ? title! : 'Title')),
      ),
      body: WebViewWidget(
        controller:  WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..loadRequest(Uri.parse(url !=null ? url! : 'https://www.google.com')),
      )
    );
  }
}
