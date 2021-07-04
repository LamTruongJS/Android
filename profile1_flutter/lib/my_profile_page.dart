

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

import 'package:profile1_flutter/edit_page.dart';
import 'package:profile1_flutter/model.dart';


class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  MyProfile myProfile;
  File _image;
  final picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width*0.9;


    return Scaffold(
      appBar: AppBar(
        title: Text("Giới Thiệu Bản Thân"),
        actions: [
          FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right:10, left: 10, bottom: 8, top:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
               color: Colors.grey,
               height: 2/3*size, width: size,
                child: _image == null
                    ? Image.asset(myProfile.imagAssest)
                    : Image.file(_image),
              ),
            ),

            SizedBox(height: 10,),
            Text("Họ Tên"),
            Text(myProfile.hoTen, style: TextStyle(color: Colors.red,fontSize: 20, fontWeight: FontWeight.bold),),
            Text("Gioi Tinh"),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RadioButton(
                    description:"Nam",
                    value: true,
                    groupValue: myProfile.gioiTinh,
                    onChanged: (value) => setState(
                        () => myProfile.gioiTinh = value
                    ),
                ),
                  RadioButton(
                      description: "Nu",
                      value: false,
                      groupValue: myProfile.gioiTinh,
                      onChanged: (value) => setState(
                          () => myProfile.gioiTinh=value
                      ),
                  ),
                ],
              ),
              ),

            SizedBox(height: 10,),
            Text("Ngày Sinh"),
            Text(myProfile.ngaySinh==null? "":"${myProfile.ngaySinh.day}/${myProfile.ngaySinh.month}/${myProfile.ngaySinh.year}", style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Text("Quê Quán:"),
            Text(myProfile.queQuan,style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Text("Sở Thích:"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(myProfile.soThich, style: TextStyle(fontSize: 20),),
            ),
            //tao button
            Row(
              children: [
                Expanded(child: SizedBox(),),
                ElevatedButton(
                      onPressed:() =>_toEditPage(context), // lay du lieu page 2 load len
                      child: Text("Edit")),
                SizedBox(width: 15,),
              ],
            ),


          ],
        ),
      ),
    );
  }

  //ham xay dung de ket noi voi page 2
  void _toEditPage(BuildContext context) async{
    var UpdateProfile = await Navigator.push(context,
    MaterialPageRoute(builder: (context) => EditPage(myProfile : myProfile,),));
    if(UpdateProfile!=null)
    setState(() {
      myProfile = UpdateProfile;
    });
  }
//Hàm lấy ảnh
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Không có ảnh');
      }
    });
  }

  //ham lay du lieu alt->insert->override method->initSate
  @override
  void initState() {
    super.initState();
    myProfile = MyProfile();
    myProfile.hoTen="Le Lam Truong";
    myProfile.gioiTinh= true;
    myProfile.queQuan="Nha Trang-Khanh Hoa";
    myProfile.soThich="choi bong chuyen";
    myProfile.imagAssest="asset/image/Top1.png";
  }

}

