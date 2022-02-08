import 'package:dwb_flutter_webview/webview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: OutlinedButton(
          child: Text("Open Webpage"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MyWebView(
                      title: "DWB_DEMO",
                      selectedUrl: "<ANGULAR_SITE_LINK>",
                    )));
          },
        ),
      ),
    );
  }
}
