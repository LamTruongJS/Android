import 'package:baitap02_onthi/pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jiffy/jiffy.dart';
import 'package:baitap02_onthi/models/model.dart';
import 'package:baitap02_onthi/pages/add_page.dart';


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
        title: Text("Quản lý nhật ký cá nhân"),
      ),
      body: Center(
          child: _allDiary(context)
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPage(),))
        },
        backgroundColor: Colors.green,
      ),
      //đặt vị trí cho button thêm
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar( //bottom navigation bar on scaffold
        color:Colors.green,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5, //marggin bottom and between
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 45,)
          ],
        ),
      ),
    );
  }
  Widget _allDiary(BuildContext context) {
    return StreamBuilder<List<NhatKySnapshot>>(
      stream: NhatKySnapshot.getAllMonhocFromFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
        {
          return ListView.separated(

            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: ListTile(
                  leading: Column(
                    children: [
                      //Lấy ngày để hiển thị đầu
                      Text((snapshot.data[index].nhatKy.Ngay).substring(0,2), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue),),
                      //Lấy thứ
                      Text(Jiffy([int.tryParse((snapshot.data[index].nhatKy.Ngay).substring(6,10)), //năm

                        int.tryParse((snapshot.data[index].nhatKy.Ngay).substring(3,5)), //tháng
                        int.tryParse((snapshot.data[index].nhatKy.Ngay).substring(0,2))   //ngày

                      ]).E,  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,))
                    ],
                  ),
                  title:
                  //Hiển thị tháng/ngày/năm
                  Text(
                    Jiffy([int.tryParse((snapshot.data[index].nhatKy.Ngay).substring(6,10)), //năm

                      int.tryParse((snapshot.data[index].nhatKy.Ngay).substring(3,5)), //tháng
                      int.tryParse((snapshot.data[index].nhatKy.Ngay).substring(0,2))  //ngày

                    ]).yMMMd, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                  //Hiển thị cảm xúc mood
                  //Hiển thị note
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data[index].nhatKy.TamTrang,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                      Text(
                        snapshot.data[index].nhatKy.GhiChu,
                        style: TextStyle(fontSize: 20),
                      ),

                    ],
                  ),
                  //trailing là vị trị nằm cuối
                  //leading là vị trí nằm đầu
                  trailing: TextButton(child: Icon(Icons.remove_red_eye,color: Colors.green,), onPressed: () => _ShowDialogDetails(snapshot.data[index],context)),
                ),

                actions: [],
                secondaryActions: [
                  IconSlideAction(
                    caption: "Xóa",
                    icon: Icons.delete_forever,
                    color: Colors.red,
                    onTap:(){
                      return _ShowDialogDelete(snapshot.data[index],context);
                    },
                  ),
                  IconSlideAction(
                    caption: "Cập nhật",
                    icon: Icons.update,
                    color: Colors.blue,
                    onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(nhatKySnapshot: snapshot.data[index],),)),
                  )
                ],
              );
            },
          );
        }
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}
void _ShowDialogDelete(NhatKySnapshot data, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text("Xác nhận", style: TextStyle(fontSize: 20),),
        content: Text("Bạn có chắc muốn xóa nhật kí này không?", style: TextStyle(fontSize: 20),),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await data.delete();
                Navigator.pop(context);
              },
              child: Text("OK", style: TextStyle(fontSize: 20),)),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Hủy", style: TextStyle(fontSize: 20),)),
        ],
      );
    },
  );
}
void _ShowDialogDetails(NhatKySnapshot data, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text("Thông tin", style: TextStyle(fontSize: 20),),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ngày viết: ${data.nhatKy.Ngay}", style: TextStyle(fontSize: 20),),
            Text("Tâm trạng: ${data.nhatKy.TamTrang}", style: TextStyle(fontSize: 20),),
            Text("Ghi chú: ${data.nhatKy.GhiChu}", style: TextStyle(fontSize: 20),),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () {

                Navigator.pop(context);
              },
              child: Text("OK")),

        ],
      );
    },
  );
}