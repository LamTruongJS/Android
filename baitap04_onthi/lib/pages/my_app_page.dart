import 'package:baitap04_onthi/pages/user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyAppPage extends StatefulWidget {
  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if (loi) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Lỗi kết nối!",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else {
      if (ketNoi == false)
        return Container(
          color: Colors.white,
          child: Center(
            child: Text(
              "Đang kết nối...",
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      else {
        return MaterialApp(
          title: 'My firebase app',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          debugShowCheckedModeBanner: false,
          home: UserPape(),
        );
      }
    }
  }
  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    } catch (e) {
      setState(() {
        loi = true;
      });
    }
  }

  @override
  void initState() {
    _initializeFirebase();
    super.initState();
  }
}
