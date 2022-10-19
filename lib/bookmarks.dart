import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ott_platform/web_page.dart';

import 'global.dart';

class bookmarkssave extends StatefulWidget {
  const bookmarkssave({Key? key}) : super(key: key);

  @override
  State<bookmarkssave> createState() => _bookmarkssaveState();
}

class _bookmarkssaveState extends State<bookmarkssave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
          itemCount: global.allbookmarks.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                inAppWebViewController.loadUrl(
                    urlRequest:
                        URLRequest(url: Uri.parse(global.allbookmarks[i])));
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "${global.allbookmarks[i]}",
                      style: TextStyle(fontSize: 19),
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                      color: Colors.black,
                      endIndent: 5,
                      indent: 5,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
