import 'package:flutter/material.dart';

import 'girdview_page.dart';

class GirdViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Grid View Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey,),
      home: MyGridViewPage(),
    );
  }
}
