import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  bool isLoading = true;

  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Policy"),
        backgroundColor: AppCustomColors.primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: _url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
