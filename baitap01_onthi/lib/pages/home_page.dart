
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:baitap01_onthi/pages/add_page.dart';
import 'package:baitap01_onthi/pages/update_page.dart';

import '../models/Models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Môn Học"),

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage(),));
        },
      ),
      body: Center(
        child: allMonHocs(context),
      ),
    );
  }
  Widget allMonHocs(BuildContext context) {
    return StreamBuilder<List<MonHocSnapshot>>(
        stream: MonHocSnapshot.getAllMonhocFromFirebase(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          else {
            return
              ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (context, index) => Divider(thickness: 0,),
              itemBuilder: (context, index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Card(
                  elevation: 3,
                    child: ListTile(
                       leading: Icon(Icons.account_balance_wallet, color: Colors.blue,),
                       title: Text(snapshot.data[index].monHoc.TenMH,
                       style: TextStyle(fontSize:25,),),
                      subtitle: Text("Số tính chỉ: "+ snapshot.data[index].monHoc.SoTC.toString(), style: TextStyle(color: Colors.green,fontSize: 18),),
                       trailing: IconButton(
                         icon: Icon(Icons.remove_red_eye , color: Colors.green,), // icon xem thông tin
                      onPressed: () {
                        _showDialogProfile(snapshot.data[index], context);
                      },
                    ),

                  ),),
                   actions: [],
                  secondaryActions: [
                    IconSlideAction(
                      caption: "Cập nhật",
                      icon: Icons.update,
                      color: Colors.blue,
                      onTap: () {
                        Navigator.push( context,
                            MaterialPageRoute( builder: (context) => UpdatePage(monHocSnapshot: snapshot.data[index]),));
                      },
                      closeOnTap: true,
                    ),
                    IconSlideAction(
                      caption: "xóa",
                      icon: Icons.delete,
                      color: Colors.red,
                      onTap: () {
                        _showDialogdelete(snapshot.data[index] , context);
                      },
                      closeOnTap: true,
                    ),
                  ],
                );
              },
              );
          }
        });
  }
  void _showDialogdelete(MonHocSnapshot data, BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Xác Nhận"),
          content: Text("Bạn có thật sự  muốn xóa môn ${data.monHoc.TenMH} không ?", style: TextStyle(fontSize: 20),),
          actions: [
            ElevatedButton(
              child: Text("Thoát", style: TextStyle(fontSize: 20),),
              onPressed: () => Navigator.pop(context),),
            ElevatedButton(
              child: Text("Ok", style: TextStyle(fontSize: 20),),
              onPressed: () async {
                await data.delete();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },);
  }
  void _showDialogProfile(MonHocSnapshot data, BuildContext context){
    showDialog(
      barrierDismissible: false,// không thể nhấn ra ngoài dialog
      context: context,
      builder: (context) {
        var Bb = "";
        data.monHoc.BatBuoc ? Bb = "Có" : Bb = "Không";
        return AlertDialog(
          title: Text("Thông tin môn học"),
          content: Text("Mã môn học: ${data.monHoc.MaMH}\n"
              "Tên môn học: ${data.monHoc.TenMH}\n"
              "Học kỳ: ${data.monHoc.HocKy.toString()}\n"
              "Số tín chỉ: ${data.monHoc.SoTC.toString()}\n"
              "Điển Trung bình: ${data.monHoc.DiemTB.toString()} \n"
              "Bắt Buộc: ${Bb}", style: TextStyle(fontSize: 20),),
          actions: [
            ElevatedButton(
              child: Text("Ok",style: TextStyle(fontSize: 20),),
              onPressed: () => Navigator.pop(context),),
          ],
        );
      },);
  }
}