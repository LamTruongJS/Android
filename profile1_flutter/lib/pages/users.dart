import 'package:flutter/material.dart';
import 'package:profile1_flutter/pages/cateloge_page.dart';

class UserPage extends StatelessWidget {
  TextEditingController NameController = TextEditingController();
  TextEditingController PassController = TextEditingController();
  String name="";
  String pass="12345";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng Nhập"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: NameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Tên Đăng Nhập",
                ),
                onChanged: (text) {
                },
              )
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: PassController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Mật Khẩu",
                ),
              ),
            ),
            ElevatedButton(

                onPressed:() => toCatalogePage(context),
                child: Text("Đăng nhập")
            ),
        ]
        ),
      ),
    );
  }
  toCatalogePage(BuildContext context){

      Navigator.push(context, MaterialPageRoute(
        builder: (context) => CatalogePage(),));
    }

}
