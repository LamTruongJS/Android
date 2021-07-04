

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:profile1_flutter/json_version/mathang_page.dart';
import 'package:profile1_flutter/json_version/model.dart';
import 'package:profile1_flutter/json_version/myproviders.dart';
import 'package:provider/provider.dart';

class CatalogeJsonVersionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cataloge"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 20),
            child: IconButton(
              icon: Icon(Icons.add_circle_outline, size: 40, color: Colors.white,),
              onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context)=> MatHangInfoPage(indexMH:-1),)
              ),
            ),

    ),
    ],
      ),
      body: Consumer<CatalogeFileProvider>(
          builder: (context, catalogeFileProvider, child) => catalogeFileProvider.listMH ==null ?
              Center(child: CircularProgressIndicator()) :
              buidListMatHang(catalogeFileProvider.listMH),
        ),

    );
  }

  buidListMatHang(List<MatHang> listMH) {
    return ListView.separated( // giữa các thành phần sẽ có khoảng cách
      itemCount: listMH.length,
      separatorBuilder: (context , index) =>Divider(thickness: 5,),
      itemBuilder: (context, index) =>_buiderItem(context, listMH[index],index),
    );
  }
  _buiderItem(BuildContext context, MatHang mh, int index) {
    return Slidable(
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
          children: [
            Container(width: 48, height: 48,color: mh.color,),
            SizedBox(width: 10,),
            Expanded(child: Text("${mh.name}"))
          ],
      ),
        ),
      ),
      actions: [


      ],
      secondaryActions: [
        IconSlideAction(
          caption: "Xóa",
          icon: Icons.delete_forever,
          color: Colors.red,
          onTap: (){

            _showAlertDialog(context, mh);
          },
        ),
        IconSlideAction(
          caption: "Cập nhật",
          icon: Icons.update_outlined,
          color: Colors.amber,
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> MatHangInfoPage(indexMH:index),)
            );

          },

        )
      ],
    );
  }

  void _showAlertDialog(BuildContext context, MatHang mh){
    AlertDialog alertDialog = AlertDialog(
      title: Text('Xác nhận'),
      content: Text("Id mặt hàng; ${mh.id}\n"
          "Tên mặt hàng: ${mh.name}\n"
          "Giá: ${mh.price}"),
      actions: [
       ElevatedButton(
            onPressed: (){
              CatalogeFileProvider cfp = context.read<CatalogeFileProvider>();
              cfp.deleteMatHang(mh);
              Navigator.pop(context);
            },
            child: Text('OK')
        ),
        ElevatedButton(
            onPressed: ()=> Navigator.pop(context), // quay trở về stack trước đó
            child: Text('Cancer')
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}
