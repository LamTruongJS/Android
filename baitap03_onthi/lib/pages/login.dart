import 'package:baitap03_onthi/pages/danhsach_nongsan.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

TextEditingController txtuser = TextEditingController();
TextEditingController txtpassword = TextEditingController();

bool hienPW = true;



class _LoginState extends State<Login>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nông sản online",
                  style: TextStyle(fontSize: 30, color: Colors.green,fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: txtuser,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                ),

                TextFormField(

                  controller: txtpassword,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: (){
                        setState(() {
                          if(hienPW == true)
                            hienPW = false;
                          else
                            hienPW =true;
                        });
                      },
                    ),
                  ),
                  obscureText: hienPW,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text("Đăng nhập", style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    if(txtuser.text == "lamtruong" && txtpassword.text == "123456")
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => dsNongSan()),
                      );
                    }
                    else{
                      _thongbao(context);
                    }

                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _thongbao(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text("Sai tài khoản hoặc mật khẩu"),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed:() => Navigator.pop(context),
              )
            ],
          );
        }
    );
  }
}