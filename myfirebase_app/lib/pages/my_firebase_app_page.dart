

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:myfirebase_app/pages/users_page.dart';

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key key}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  bool ketNoi= false;
  bool loi=false;
  @override
  Widget build(BuildContext context) {
    if (loi == true)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text('Lỗi kết nối', textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),),
        ),
      );
    else if (ketNoi == false)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text('Đang kết nối....', textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),),
        ),
      );
    else
      return MaterialApp(
          title: "My Firebase App",
          theme: ThemeData(
              primarySwatch: Colors.blue
          ),
          home: UsersPage()
      );
  }
  Future<void> _initializeFirebase() async{
    try{
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    }
    catch(e){
      setState(() {
        loi= true;
      });
    }
  }

  @override
  void initState() {
    _initializeFirebase();
    super.initState();
  }

}
