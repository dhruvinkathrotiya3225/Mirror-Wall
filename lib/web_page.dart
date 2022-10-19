import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'global.dart';

class website_page extends StatefulWidget {
  const website_page({Key? key}) : super(key: key);

  @override
  State<website_page> createState() => _website_pageState();
}

late InAppWebViewController inAppWebViewController;

class _website_pageState extends State<website_page> {
  late PullToRefreshController pullToRefreshController;
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          await inAppWebViewController.reload();
        }
        if (Platform.isIOS) {
          Uri? uri = await inAppWebViewController.getUrl();

          await inAppWebViewController.loadUrl(
              urlRequest: URLRequest(url: uri));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Web Page"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () async {
                if (await inAppWebViewController.canGoBack()) {
                  await inAppWebViewController.goBack();
                }
              },
              icon: Icon(Icons.keyboard_arrow_left)),
          IconButton(
              onPressed: () async {
                if (Platform.isAndroid) {
                  await inAppWebViewController.reload();
                }
                if (Platform.isIOS) {
                  Uri? uri = await inAppWebViewController.getUrl();

                  await inAppWebViewController.loadUrl(
                      urlRequest: URLRequest(url: uri));
                }
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                if (await inAppWebViewController.canGoForward()) {
                  await inAppWebViewController.goForward();
                }
              },
              icon: Icon(Icons.keyboard_arrow_right)),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "f1",
            backgroundColor: Colors.black,
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Search"),
                  content: TextFormField(
                    onFieldSubmitted: (val) {
                      Navigator.of(context).pop();
                    },
                    controller: searchcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "search"),
                    onChanged: (val) {
                      inAppWebViewController.loadUrl(
                          urlRequest: URLRequest(
                              url: Uri.parse(
                                  "https://www.google.com/search?q=$val")));
                    },
                  ),
                ),
              );
            },
            child: Icon(Icons.search),
          ),
          FloatingActionButton(
            heroTag: "f2",
            backgroundColor: Colors.black,
            onPressed: () async {
              await inAppWebViewController.stopLoading();
            },
            child: Icon(Icons.cancel),
          ),
          FloatingActionButton(
            heroTag: "f3",
            backgroundColor: Colors.black,
            onPressed: () async {
              Uri? uri = await inAppWebViewController.getUrl();

              global.allbookmarks.add(uri.toString());
            },
            child: Icon(Icons.bookmark_add_outlined),
          ),
          FloatingActionButton(
            heroTag: "f4",
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.of(context).pushNamed("bookmarkssavepage");
            },
            child: Icon(Icons.save),
          ),
        ],
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        )),
        onLoadStop: (controller, uri) async {
          await pullToRefreshController.endRefreshing();
        },
        initialUrlRequest:
            URLRequest(url: Uri.parse("${global.linkpage[res]["link"]}")),
        pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (val) {
          setState(() {
            inAppWebViewController = val;
          });
        },
      ),
    );
  }
}
