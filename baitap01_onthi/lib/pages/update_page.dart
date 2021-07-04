import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baitap01_onthi/pages/app_page.dart';

import '../models/Models.dart';

class UpdatePage extends StatefulWidget {
  final  MonHocSnapshot monHocSnapshot;
  UpdatePage({Key key,@required this.monHocSnapshot}) : super(key: key);
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  TextEditingController diemMH = TextEditingController();
  TextEditingController soTC = TextEditingController();
  TextEditingController hocKy = TextEditingController();
  TextEditingController maMH = TextEditingController();
  TextEditingController tenMH = TextEditingController();
  bool batBuoc = false;
  @override
  Widget build(BuildContext context) {
    if(widget.monHocSnapshot!=null)
    {
      diemMH.text = widget.monHocSnapshot.monHoc.DiemTB.toString();
      soTC.text = widget.monHocSnapshot.monHoc.SoTC.toString();
      hocKy.text = widget.monHocSnapshot.monHoc.HocKy.toString();
      maMH.text = widget.monHocSnapshot.monHoc.MaMH;
      tenMH.text = widget.monHocSnapshot.monHoc.TenMH;
      batBuoc = widget.monHocSnapshot.monHoc.BatBuoc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật thông tin Môn học"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextEdit(maMH, "Mã môn học"),
            SizedBox(height: 20),
            _buildTextEdit(tenMH, "Tên môn Học"),
            SizedBox(height: 20),
            _buildTextEdit(soTC, "Số tín chỉ"),
            SizedBox(height: 20),
            _buildTextEdit(hocKy, "Học kỳ"),
            SizedBox(height: 20),
            _buildTextEdit(diemMH, "Điểm trung bình môn"),
            SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Môn học có bắc buộc không !",style: TextStyle(fontSize: 20), ),
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: widget.monHocSnapshot.monHoc.BatBuoc,
                    onChanged: (bool value) {
                      setState(() {
                        widget.monHocSnapshot.monHoc.BatBuoc = value;
                      });
                    },
                  ),]
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed:() async {
                        await widget.monHocSnapshot.update(
                              int.parse(diemMH.text),
                              int.parse(soTC.text),
                              int.parse(hocKy.text),
                              maMH.text,
                              tenMH.text,
                              batBuoc);
                    _showDialogUpdate(context);
                  },
                    child: Text("Cập nhật",style: TextStyle(fontSize: 20),),),
                  SizedBox(width: 10,),
                  ElevatedButton(
                      onPressed:()=> Navigator.pop(context),
                      child: Text("Hủy",style: TextStyle(fontSize: 20),))
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextEdit(TextEditingController controller, String label){
    return TextField(
      style: TextStyle(fontSize: 22),
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          )
      ),
    );
  }
  void _showDialogUpdate(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thông báo !"),
          content: Text("Cập nhật thành công môn học thành công môn học "+ tenMH.text, style: TextStyle(fontSize: 20), ),
          actions: [
            ElevatedButton(
              child: Text("OK",style: TextStyle(fontSize: 20),),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AppPage(),));
              },
            ),
          ],
        );
      },);
  }
}
