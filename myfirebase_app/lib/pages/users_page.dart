


import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myfirebase_app/models/user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Firebase App"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:()=> _showDialogAdd(context),
        ),

        body: Center(
          child: _streamListWidget(context),

          // child: FutureBuilder<UserSnapshot>(
          //   future: UserSnapshot().getUserFromFireBaseByID("2"),
          //   builder: (context, userSnapshot){
          //     if(userSnapshot.hasData)
          //       return
          //       Text("${userSnapshot.data.user.ten}");
          //     else
          //       return
          //           Text("Không có dữ liệu");
          //   },
        )

    );

  }

  Widget _streamWidget(BuildContext context){
    return StreamBuilder<UserSnapshot>(
      stream: UserSnapshot.getDocFromFirebase("2"),
      builder: (context, userSnapshot){
        if(!userSnapshot.hasData)
          return Text("no data");
        else
        {
          return Text("${userSnapshot.data.user.ten}");
        }
      },
    );
  }
  Widget _allUsers(BuildContext context){
    return StreamBuilder<List<UserSnapshot>>(
      stream: UserSnapshot.getAllUserFromFirebase(),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        else
          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder:(context, index) => Divider(thickness: 2,) ,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: ListTile(
                    leading: Icon(Icons.face_sharp),
                    title: Text(snapshot.data[index].user.ten,style:TextStyle(fontSize: 20),),
                    subtitle: Text(snapshot.data[index].user.nam_sinh.toString()),

                  ),
                  actions: [
                    IconSlideAction(
                      caption:"Cập Nhật",
                      icon: Icons.update,
                      color: Colors.green,
                      onTap: (){
                        _showDialogAdd(context);
                      },
                      closeOnTap: true,
                    )
                  ],
                secondaryActions: [
                  IconSlideAction(
                    caption:"Xóa",
                    icon: Icons.delete_forever,
                    color: Colors.red,
                    onTap: (){
                      _showDialog(snapshot.data[index],context);
                    },
                    closeOnTap: true,
                  )
                ],
                  );
            },

             );
      },
    );
  }

  void _showDialog(UserSnapshot data, BuildContext context){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context)
    {
      return AlertDialog(
        title: Text("Xác nhận"),
        content: Text("Bạn có muốn xóa user ${data.user.ten} không?"),
        actions: [
          ElevatedButton(
            child: Icon(Icons.cancel, color: Colors.red,),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Icon(Icons.check, color: Colors.red,),
            onPressed: () async {
              await data.delete();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
    );
  }

  TextEditingController txtAddName = TextEditingController();
  TextEditingController txtAddQuenQuan = TextEditingController();
  TextEditingController txtAddNamSinh = TextEditingController();
  _showDialogAdd(BuildContext context,{UserSnapshot userSnapshot}){
    String title="Thêm User";
    String buttonLabel="Thêm";
    showDialog(
      barrierDismissible: false,
        context: context,
        builder:(context){
        if(userSnapshot!=null) {
          txtAddName.text = userSnapshot.user.ten;
          txtAddQuenQuan.text = userSnapshot.user.que_quan;
          txtAddNamSinh.text = userSnapshot.user.nam_sinh.toString();
          title = "Cập Nhật";
          buttonLabel = "Cập Nhật";
        }
        return AlertDialog(
          title: Text(title),
          content: Column(
            children: [

              TextField(
                controller: txtAddName,
                decoration: InputDecoration(labelText: "Tên"),
              ),
              TextField(
                controller: txtAddQuenQuan,
                decoration: InputDecoration(labelText: "Quê Quán"),
              ),
              TextField(
                controller: txtAddNamSinh,
                decoration: InputDecoration(labelText: "Năm Sinh"),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text("Hủy"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
             child: Text(buttonLabel),
              onPressed: () async{
               if(userSnapshot == null){
                 User user =User(
                   ten: txtAddName.text,
                   que_quan: txtAddQuenQuan.text,
                   nam_sinh: int.parse(txtAddNamSinh.text),
                 );
                 await addUserToFirebase(user);
               }
               else{

               }
               Navigator.pop(context);
              },
            ),
          ],
        );

        },);
  }

  @override
  void dispose() {
    txtAddName.dispose();
    txtAddQuenQuan.dispose();
    txtAddNamSinh.dispose();
    super.dispose();
  }

  Widget _streamListWidget(BuildContext context){
    return StreamBuilder<List<UserSnapshot>>(
      stream: UserSnapshot.getAllUserFromFirebase(),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Text("no data");
        else
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder:(context, index)=> ListTile(
                title: Text(snapshot.data[index].user.ten,style:TextStyle(fontSize: 20),),
                subtitle: Text(snapshot.data[index].user.nam_sinh.toString()),

                ),



          );
      },
    );
  }
// Widget _futureWiget(BuildContext context){
//   return FutureBuilder<UserSnapshot>{
//     future: UserSnapshot().getUserFromFireBaseByID("2"),
//     builder: (context, userSnapshot){
//       if(userSnapshot.hasData)
//         return
//             Text("${userSnapshot.data.user.ten}");
//       else
//         return
//             Text("Không có dữ liệu");
//     },
//   };
// }
  }

