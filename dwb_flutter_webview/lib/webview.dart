import 'dart:async';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String title;
  final String selectedUrl;
  String message = "";
  String toSendText = "";

  MyWebView({
    Key? key,
    required this.title,
    required this.selectedUrl,
  }) : super(key: key);

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var deviceInfo = new DeviceInfoPlugin();
          AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
          String text = "Running on model: " + androidDeviceInfo.model! + "\\n";
          text += "Product name: ${androidDeviceInfo.product}\\n";
          text += "Android ID: ${androidDeviceInfo.androidId}\\n";
          // text = androidDeviceInfo.product!.toString();
          print(text);
          _webViewController.runJavascript("displaySomething(' $text ');");
          print("Send device information to javascript");
        },
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Text(
              widget.message == ''
                  ? 'No message received from the website'
                  : widget.message,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: WebView(
              debuggingEnabled: true,
              initialUrl: "https://4600-117-230-140-189.ngrok.io/",
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>{_javascriptChannel()},
              onWebViewCreated: (WebViewController webViewController) async {
                _webViewController = webViewController;
                // await _loadLocalWeb();
                print("WebView created");
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
          )
        ],
      ),
    );
  }

  JavascriptChannel _javascriptChannel() {
    return JavascriptChannel(
        name: 'PRINT',
        onMessageReceived: (JavascriptMessage message) {
          setState(() {
            widget.message = message.message;
          });
        });
  }

  _loadLocalWeb() async {
    String fileText = await rootBundle.loadString('assets/web/index.html');
    _webViewController.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
