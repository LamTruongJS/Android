
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baitap01_onthi/pages/home_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AppPage> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if(loi == true){
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Lỗi kết nối!",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18,color: Colors.deepPurpleAccent),),
        ),
      );
    }else{
      if(ketNoi == false){
        return Container(
          color: Colors.white,
          child: Center(
            child: Text("Đang kết nối...",
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
          ),
        );
      }else{
        return MaterialApp(
          title: "My Firebase App",
          theme: ThemeData(
            primarySwatch: Colors.green,

          ),
          home: HomePage(),

        );


      }
    }
  }

  Future<void> _initializeFirebase() async{
    try{
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    }catch(e){
      setState(() {
        //để vẽ lại giao diện
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