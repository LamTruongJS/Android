import 'package:baitap03_onthi/models/nongsan_model.dart';
import 'package:baitap03_onthi/pages/app_page.dart';
import 'package:baitap03_onthi/pages/chitiet_nongsan.dart';
import 'package:baitap03_onthi/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
List<NongSan> giohang =  List<NongSan>();


class dsNongSan extends StatefulWidget {
  const dsNongSan({Key key}) : super(key: key);

  @override
  _dsNongSanState createState() => _dsNongSanState();
}

class _dsNongSanState extends State<dsNongSan> {
  // ignore: deprecated_member_use


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Giải cứu nông sản"),

          leading: GestureDetector(
            child: Icon(Icons.logout),
            onTap: ()=> _thongbaoThoat(context),
          ),
        ),

        body: Center(
          child: _allNongSan(context),
        )
    );
  }

  @override
  Widget _allNongSan(BuildContext context)
  {

    return StreamBuilder<List<NongSanSnapshot>>(
      stream: getAllNongSanFromFireBase(),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),); //quay tròn
        else{
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:200,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),

            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, index) {

              return Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        //data[index] là để xác định đúng vị trí của dữ liệu mình cần cập nhật ở trang cập nhật
                        MaterialPageRoute(builder: (context) => ChitietNongSan(nongSanSnapshot: snapshot.data[index],)));

                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(snapshot.data[index].nongSan.url,width: 250,height: 120,),
                        Text(snapshot.data[index].nongSan.tenns, style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                        Text("Giá: " + NumberFormat.currency(locale: 'vi').format(snapshot.data[index].nongSan.gia)+"/Kg",style: TextStyle(color: Colors.red,fontSize: 20),)
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15)),
              );
            },
          );
        }
      },
    );
  }
  Widget _thongbaoThoat(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Chú ý"),
              content: Text("Bạn có muốn thoát"),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyFirebaseApp(),)),
                    child: Text("OK")),
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: ()=> Navigator.pop(context),
                    child: Text("Hủy"))
              ]);
        });
  }
}