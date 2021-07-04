import 'package:flutter/material.dart';

import 'listview_page.dart';

class ListViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ListView App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: ListViewSaperatedPage(),
    );
  }
}
