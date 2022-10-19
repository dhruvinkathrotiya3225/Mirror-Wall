import 'package:flutter/material.dart';
import 'package:ott_platform/web_page.dart';

import 'bookmarks.dart';
import 'global.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => homepage(),
        "website_page": (context) => website_page(),
        "bookmarkssavepage": (context) => bookmarkssave(),
      },
    ),
  );
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Educational websites "),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
            itemCount: global.container.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("website_page", arguments: i);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              NetworkImage("${global.container[i]["image"]}"),
                          fit: BoxFit.cover,
                          opacity: 0.4),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5,
                            spreadRadius: 4,
                            blurStyle: BlurStyle.solid),
                      ],
                    ),
                    child: Text(
                      "${global.container[i]["name"]}",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                ),
              );
            }));
  }
}
