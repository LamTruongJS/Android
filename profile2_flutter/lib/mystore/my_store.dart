import 'package:flutter/material.dart';
import 'file:///D:/StudyIT/Nam3/HK2/ThietBiDiDong/profile2_flutter/lib/mystore/my_store_page.dart';

class MyStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyStorePage(),
      theme: ThemeData(primaryColor: Colors.grey,),

    );
  }
}
