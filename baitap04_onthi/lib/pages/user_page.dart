import 'package:baitap04_onthi/models/chitieu_model.dart';
import 'package:baitap04_onthi/models/vi_model.dart';
import 'package:baitap04_onthi/pages/add_page.dart';
import 'package:baitap04_onthi/pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserPape extends StatefulWidget {
  const UserPape({Key key}) : super(key: key);
  @override
  _UserPapeState createState() => _UserPapeState();
}

ViSnapshot visn;
class _UserPapeState extends State<UserPape> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thu chi"),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 500,
              height: 90,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.black26),)
              ),
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _streamWidget(context)
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text("Chi tiết thu chi", style: TextStyle(fontSize: 25),),
            ),
            Container(
              width: 500,
              height: 500,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _allCT(context),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage(vsn: visn,),)),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
Widget _streamWidget(BuildContext context) {
  return StreamBuilder<ViSnapshot>(
    stream: ViSnapshot.getUserFromFirebase("1"),
    builder: (context, viSnapshot) {
      if (viSnapshot.hasData){
        visn = viSnapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Thu: ${viSnapshot.data.vi.thu}", style: TextStyle(color: Colors.blue, fontSize: 20), textDirection: TextDirection.ltr,),
            Text("Chi: ${viSnapshot.data.vi.chi}", style: TextStyle(color: Colors.red, fontSize: 20),textDirection: TextDirection.ltr),
            Text("Còn: ${viSnapshot.data.vi.thu - viSnapshot.data.vi.chi}", style: TextStyle(color: Colors.green, fontSize: 20),textDirection: TextDirection.ltr),
          ],
        );
      }

      else
        return Text("Không có dữ liệu");
    },
  );
}
Widget _allCT(BuildContext context) {
  return StreamBuilder<List<CTSnapshot>>(
    stream: getAllSubjectFromFireBase(),
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
              child: Container(
                width: 500,
                height: 80,
                decoration: BoxDecoration(
                    color: snapshot.data[index].ct.thuchi==true?Colors.blue[100]:Colors.red[100],
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),

                child: ListTile(
                  leading: snapshot.data[index].ct.thuchi==true?Icon(Icons.add):Icon(Icons.remove),
                  title: Text(snapshot.data[index].ct.lido,style: TextStyle(fontSize: 20),),


                  subtitle:

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Số tiền: ${snapshot.data[index].ct.sotien}",
                        style: TextStyle(fontSize: 20, color: Colors.pink),
                      ),
                      Text(
                        snapshot.data[index].ct.thoigian,
                        style: TextStyle(fontSize: 20),
                      ),

                    ],
                  ),
                  trailing: TextButton(child: Icon(Icons.remove_red_eye,color: Colors.green,), onPressed: () => _ShowDialogDetails(snapshot.data[index],context)),

                ),
              ),

              actions: [],
              secondaryActions: [
                IconSlideAction(
                  caption: "Xóa",
                  icon: Icons.delete_forever,
                  color: Colors.red,
                  onTap:() =>  _ShowDialogDelete(snapshot.data[index],context),
                ),
                IconSlideAction(
                    caption: "Cập nhật",
                    icon: Icons.update,
                    color: Colors.blue,
                    onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) =>EditPage(ctSnapshot: snapshot.data[index],visn: visn,),))
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
void _ShowDialogDelete(CTSnapshot data, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text("Xác nhận"),
        content: Text("Bạn có chắc muốn xóa thu chi này không?"),
        actions: [
          ElevatedButton(
              onPressed: () async {
                if(data.ct.thuchi){
                  visn.vi.thu -= data.ct.sotien;
                  await visn.updateVi(thu: visn.vi.thu);
                }
                else{
                  visn.vi.chi -= data.ct.sotien;
                  await visn.updateVi(chi: visn.vi.chi);
                }
                await data.delete();
                Navigator.pop(context);
              },
              child: Text("OK")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Thoát")),
        ],
      );
    },
  );
}
void _ShowDialogDetails(CTSnapshot data, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text("Thông tin"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Lí do: ${data.ct.lido}",style: TextStyle(fontSize: 25),),
            Text("Số tiền: ${data.ct.sotien}",style: TextStyle(fontSize: 25),),
            data.ct.thuchi==true?Text("Ngày thu: ${data.ct.thoigian}",style: TextStyle(fontSize: 25),):Text("Ngày chi: ${data.ct.thoigian}",style: TextStyle(fontSize: 25),),

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