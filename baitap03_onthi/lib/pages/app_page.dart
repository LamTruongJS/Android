import 'package:baitap03_onthi/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key key}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  //2 trạng thái
  bool ketNoi = false;//chưa kết nối
  bool error = false;//báo lỗi

  @override
  Widget build(BuildContext context) {

    if(error == true)//nếu cps lỗi
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Lỗi kết nối!",textDirection: TextDirection.ltr,style: TextStyle(fontSize: 18),),
        ),
      );
    else
    if(ketNoi == false)
      return Container(
        color: Colors.white,
        child: Center(
          //chỉ ra vị tr của chữ:  trái sang phải
          child: Text("Đang kết nối...",textDirection: TextDirection.ltr,style: TextStyle(fontSize: 18),),
        ),
      );
    else //trả về MaterialApp, Provider, ChangeNotifyProvider
      return
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Kết nối firebase",
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Text("Nông sản App"),
            ),
            body: Login(),

          ),
        );
  }



  Future<void> _initializeFirebase() async{
    try{
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    }catch(e){
      setState(() {
        error=true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _initializeFirebase();
    super.initState();
  }
}